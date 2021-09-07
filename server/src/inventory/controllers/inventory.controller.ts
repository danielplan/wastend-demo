import { ItemCategory } from './../models/category.entity';
import { JwtGuard } from './../../auth/guards/jwt.guard';
import { InventoryService } from '../services/inventory.service';
import {
    Body,
    Controller,
    Delete,
    Get,
    Param,
    Post,
    Put,
    Request,
    UseGuards,
} from '@nestjs/common';
import { ApiBasicAuth, ApiBody, ApiOperation, ApiParam } from '@nestjs/swagger';
import { InventoryItem } from '../models/item.entity';

@Controller('inventory')
export class InventoryController {
    constructor(private inventoryService: InventoryService) {}

    @Get()
    @ApiOperation({
        summary: 'Finds all the inventory items in your group',
        tags: ['Inventory'],
    })
    @ApiBasicAuth('JWT')
    @UseGuards(JwtGuard)
    getAllItems(@Request() req): Promise<InventoryItem[]> {
        return this.inventoryService.getAllInventoryItems(req.user);
    }

    @Get('categories')
    @ApiOperation({
        summary: 'Finds all categories for Inventory Items',
        tags: ['Inventory'],
    })
    getAllCategories(): Promise<ItemCategory[]> {
        return this.inventoryService.getAllCategories();
    }

    @Post()
    @ApiOperation({
        summary: 'Adds an inventory item to your group`s inventory',
        tags: ['Inventory'],
    })
    @ApiBody({ type: InventoryItem })
    @UseGuards(JwtGuard)
    @ApiBasicAuth('JWT')
    addItem(
        @Body() inventoryItem: InventoryItem,
        @Request() req,
    ): Promise<InventoryItem> {
        return this.inventoryService.addInventoryItem(inventoryItem, req.user);
    }

    @Put(':id')
    @ApiOperation({ summary: 'Updates an inventory item', tags: ['Inventory'] })
    @ApiParam({ type: Number, name: 'id' })
    @ApiBody({ type: InventoryItem })
    @UseGuards(JwtGuard)
    @ApiBasicAuth('JWT')
    updateItem(
        @Param('id') id: number,
        @Body() inventoryItem: InventoryItem,
        @Request() req,
    ): Promise<InventoryItem> {
        return this.inventoryService.updateInventoryItem(
            id,
            inventoryItem,
            req.user,
        );
    }

    @Delete(':id')
    @ApiOperation({ summary: 'Deletes an inventory item', tags: ['Inventory'] })
    @ApiParam({ type: Number, name: 'id' })
    @UseGuards(JwtGuard)
    @ApiBasicAuth('JWT')
    deleteItem(
        @Param('id') id: number,
        @Request() req,
    ): Promise<InventoryItem> {
        return this.inventoryService.deleteInventoryItem(id, req.user);
    }
}
