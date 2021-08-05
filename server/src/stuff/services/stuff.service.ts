import { StuffItem } from './../model/item.interface';
import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { StuffItemEntity } from '../model/item.entity';
import { from, Observable } from 'rxjs';

@Injectable()
export class StuffService {
    constructor(
        @InjectRepository(StuffItemEntity)
        private readonly stuffItemRepository: Repository<StuffItemEntity>
    ) {}
    
    addStuffItem(stuffItem: StuffItem): Observable<StuffItem> {
        return from(this.stuffItemRepository.save(stuffItem));
    }
    
    getAllStuffItems() {
        return this.stuffItemRepository.find();
    }
}
