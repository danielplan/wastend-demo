import { Validator } from './../../validator';
import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { InventoryItem } from '../models/item.entity';

@Injectable()
export class InventoryService {
    constructor(
        @InjectRepository(InventoryItem)
        private readonly inventoryItemRepository: Repository<InventoryItem>,
    ) {}

    addInventoryItem(inventoryItem: InventoryItem): Promise<InventoryItem> {
        InventoryItem.validate(inventoryItem);
        return this.inventoryItemRepository.save(inventoryItem);
    }

    getAllInventoryItems(): Promise<InventoryItem[]> {
        return this.inventoryItemRepository.find();
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
