import { InventoryItem } from '../models/item.interface';
import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { DeleteResult, Repository, UpdateResult } from 'typeorm';
import { InventoryItemEntity } from '../models/item.entity';
import { from, Observable } from 'rxjs';

@Injectable()
export class InventoryService {
    constructor(
        @InjectRepository(InventoryItemEntity)
        private readonly inventoryItemRepository: Repository<InventoryItemEntity>,
    ) {}

    addInventoryItem(inventoryItem: InventoryItem): Observable<InventoryItem> {
        return from(this.inventoryItemRepository.save(inventoryItem));
    }

    getAllInventoryItems(): Observable<InventoryItem[]> {
        return from(this.inventoryItemRepository.find());
    }

    updateInventoryItem(
        id: number,
        inventoryItem: InventoryItem,
    ): Observable<UpdateResult> {
        return from(this.inventoryItemRepository.update(id, inventoryItem));
    }

    deleteInventoryItem(id: number): Observable<DeleteResult> {
        return from(this.inventoryItemRepository.delete(id));
    }
}
