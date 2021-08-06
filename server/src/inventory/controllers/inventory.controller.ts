import { UpdateResult, DeleteResult } from 'typeorm';
import { Observable } from 'rxjs';
import { InventoryService } from '../services/inventory.service';
import {
    Body,
    Controller,
    Delete,
    Get,
    Param,
    Post,
    Put,
} from '@nestjs/common';
import { InventoryItem } from '../models/item.interface';
import { ApiBody, ApiOperation, ApiParam } from '@nestjs/swagger';
import { InventoryItemEntity } from '../models/item.entity';

@Controller('inventory')
export class InventoryController {
    constructor(private inventoryService: InventoryService) {}

    @Get()
    @ApiOperation({
        summary: 'Finds all the inventory item',
        tags: ['Inventory'],
    })
    getAllItems(): Observable<InventoryItem[]> {
        return this.inventoryService.getAllInventoryItems();
    }

    @Post()
    @ApiOperation({ summary: 'Adds an inventory item', tags: ['Inventory'] })
    @ApiBody({ type: InventoryItemEntity })
    addItem(@Body() inventoryItem: InventoryItem): Observable<InventoryItem> {
        return this.inventoryService.addInventoryItem(inventoryItem);
    }

    @Put(':id')
    @ApiOperation({ summary: 'Updates an inventory item', tags: ['Inventory'] })
    @ApiParam({ type: Number, name: 'id' })
    @ApiBody({ type: InventoryItemEntity })
    updateItem(
        @Param('id') id: number,
        @Body() inventoryItem: InventoryItem,
    ): Observable<UpdateResult> {
        return this.inventoryService.updateInventoryItem(id, inventoryItem);
    }

    @Delete(':id')
    @ApiOperation({ summary: 'Deletes an inventory item', tags: ['Inventory'] })
    @ApiParam({ type: Number, name: 'id' })
    deleteItem(@Param('id') id: number): Observable<DeleteResult> {
        return this.inventoryService.deleteInventoryItem(id);
    }
}
