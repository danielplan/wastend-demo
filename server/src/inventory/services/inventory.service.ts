import { InventoryItem } from '../model/item.interface';
import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { InventoryItemEntity } from '../model/item.entity';
import { from, Observable } from 'rxjs';

@Injectable()
export class StuffService {
    constructor(
        @InjectRepository(InventoryItemEntity)
        private readonly stuffItemRepository: Repository<InventoryItemEntity>,
    ) {}

    addStuffItem(stuffItem: InventoryItem): Observable<InventoryItem> {
        return from(this.stuffItemRepository.save(stuffItem));
    }

    getAllStuffItems() {
        return this.stuffItemRepository.find();
    }
}
