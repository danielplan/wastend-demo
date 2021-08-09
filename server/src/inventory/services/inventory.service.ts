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
            return this.inventoryItemRepository.find({ group: user.group });
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
    ): Promise<InventoryItem> {
        InventoryItem.validate(inventoryItem);
        try {
            let item: InventoryItem =
                await this.inventoryItemRepository.findOneOrFail(id);
            item = { ...item, ...inventoryItem, id: parseInt(id.toString()) };
            this.inventoryItemRepository.update(id, item);
            return item;
        } catch (e) {
            Validator.throwNotFound();
        }
    }

    async deleteInventoryItem(id: number): Promise<InventoryItem> {
        try {
            const item: InventoryItem =
                await this.inventoryItemRepository.findOneOrFail(id);
            this.inventoryItemRepository.remove(item);
            return item;
        } catch (e) {
            Validator.throwNotFound();
        }
    }
}
