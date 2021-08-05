import { from, Observable } from 'rxjs';
import { StuffService } from '../services/inventory.service';
import { Body, Controller, Get, Post } from '@nestjs/common';
import { InventoryItem } from '../model/item.interface';

@Controller('inventory')
export class InventoryController {
    constructor(private stuffService: StuffService) {}

    @Post('item')
    addStuffItem(@Body() stuffItem: InventoryItem): Observable<InventoryItem> {
        return this.stuffService.addStuffItem(stuffItem);
    }
}
