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
    ) {}

    addInventoryItem(
        inventoryItem: InventoryItem,
        user: User,
    ): Promise<InventoryItem> {
        if (user.group) {
            InventoryItem.validate(inventoryItem);
            inventoryItem.group = user.group;
            return this.inventoryItemRepository.save(inventoryItem);
        } else {
            Validator.throwErrors(
                ['User has to be in a group'],
                HttpStatus.BAD_REQUEST,
            );
        }
    }

    getAllInventoryItems(user: User): Promise<InventoryItem[]> {
        if (user.group) {
            return this.inventoryItemRepository.find({
                where: {
                    group: user.group,
                },
                relations: ['category'],
            });
        } else {
            Validator.throwErrors(
                ['User has to be in a group'],
                HttpStatus.BAD_REQUEST,
            );
        }
    }

    async updateInventoryItem(
        id: number,
        inventoryItem: InventoryItem,
        user: User,
    ): Promise<InventoryItem> {
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

        if (user.group && user.group.id === item.group.id) {
            item = {
                ...item,
                ...inventoryItem,
                id: parseInt(id.toString()),
            };
            this.inventoryItemRepository.update(id, item);
            return item;
        } else {
            Validator.throwErrors(
                ['This item is not in your group'],
                HttpStatus.BAD_REQUEST,
            );
        }
    }

    async deleteInventoryItem(id: number, user: User): Promise<InventoryItem> {
        const item: InventoryItem = await this.inventoryItemRepository.findOne(
            id,
            { relations: ['group'] },
        );
        if (item === undefined) {
            Validator.throwNotFound();
        }

        if (user.group && item.group.id === user.group.id) {
            this.inventoryItemRepository.remove(item);
            return item;
        } else {
            Validator.throwErrors(
                ['This item is not in your group'],
                HttpStatus.BAD_REQUEST,
            );
        }
    }
}
