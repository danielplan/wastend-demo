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
import { ApiBody, ApiOperation, ApiParam } from '@nestjs/swagger';
import { InventoryItem } from '../models/item.entity';

@Controller('inventory')
export class InventoryController {
    constructor(private inventoryService: InventoryService) {}

    @Get()
    @ApiOperation({
        summary: 'Finds all the inventory item',
        tags: ['Inventory'],
    })
    getAllItems(): Promise<InventoryItem[]> {
        return this.inventoryService.getAllInventoryItems();
    }

    @Post()
    @ApiOperation({ summary: 'Adds an inventory item', tags: ['Inventory'] })
    @ApiBody({ type: InventoryItem })
    addItem(@Body() inventoryItem: InventoryItem): Promise<InventoryItem> {
        return this.inventoryService.addInventoryItem(inventoryItem);
    }

    @Put(':id')
    @ApiOperation({ summary: 'Updates an inventory item', tags: ['Inventory'] })
    @ApiParam({ type: Number, name: 'id' })
    @ApiBody({ type: InventoryItem })
    updateItem(
        @Param('id') id: number,
        @Body() inventoryItem: InventoryItem,
    ): Promise<InventoryItem> {
        return this.inventoryService.updateInventoryItem(id, inventoryItem);
    }

    @Delete(':id')
    @ApiOperation({ summary: 'Deletes an inventory item', tags: ['Inventory'] })
    @ApiParam({ type: Number, name: 'id' })
    deleteItem(@Param('id') id: number): Promise<InventoryItem> {
        return this.inventoryService.deleteInventoryItem(id);
    }
}
