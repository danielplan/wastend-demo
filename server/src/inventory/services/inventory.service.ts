import { Validator } from './../../validator';
import { HttpStatus, Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { InventoryItem } from '../models/item.entity';
import { User } from 'src/auth/models/user.entity';

@Injectable()
export class InventoryService {
    constructor(
        @InjectRepository(InventoryItem)
        private readonly inventoryItemRepository: Repository<InventoryItem>,
        @InjectRepository(User)
        private readonly userRepository: Repository<User>,
    ) {}

    async addInventoryItem(
        inventoryItem: InventoryItem,
        user: User,
    ): Promise<InventoryItem> {
        user = await this.userRepository.findOne(user.id, {
            relations: ['group'],
        });
        user.assertIsInGroup();
        InventoryItem.validate(inventoryItem);
        inventoryItem.group = user.group;
        return this.inventoryItemRepository.save(inventoryItem);
    }

    async getAllInventoryItems(user: User): Promise<InventoryItem[]> {
        user = await this.userRepository.findOne(user.id, {
            relations: ['group'],
        });
        user.assertIsInGroup();
        return this.inventoryItemRepository.find({
            where: {
                group: user.group,
            },
            relations: ['category'],
        });
    }

    async updateInventoryItem(
        id: number,
        inventoryItem: InventoryItem,
        user: User,
    ): Promise<InventoryItem> {
        user = await this.userRepository.findOne(user.id, {
            relations: ['group'],
        });
        InventoryItem.validate(inventoryItem);

        let item: InventoryItem = await this.inventoryItemRepository.findOne(
            id,
            {
                relations: ['group', 'category'],
            },
        );
        if (item === undefined) {
            Validator.throwNotFound();
        }

        this.assertItemIsInGroup(user, item);
        item = {
            ...item,
            ...inventoryItem,
            group: item.group,
            id: parseInt(id.toString()),
        };
        this.inventoryItemRepository.update(id, item);
        return item;
    }

    async deleteInventoryItem(id: number, user: User): Promise<InventoryItem> {
        user = await this.userRepository.findOne(user.id, {
            relations: ['group'],
        });
        const item: InventoryItem = await this.inventoryItemRepository.findOne(
            id,
            { relations: ['group'] },
        );
        if (item === undefined) {
            Validator.throwNotFound();
        }

        this.assertItemIsInGroup(user, item);
        this.inventoryItemRepository.remove(item);
        return item;
    }

    assertItemIsInGroup(user: User, item: InventoryItem) {
        if (!user.group || item.group.id !== user.group.id) {
            Validator.throwErrors(
                ['This item is not in your group'],
                HttpStatus.BAD_REQUEST,
            );
        }
    }
}
