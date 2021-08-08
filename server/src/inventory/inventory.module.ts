import { InventoryController } from './controllers/inventory.controller';
import { TypeOrmModule } from '@nestjs/typeorm';
import { Module } from '@nestjs/common';
import { InventoryService } from './services/inventory.service';
import { InventoryItem } from './models/item.entity';
import { InventoryCategory } from './models/category.entity';

@Module({
    imports: [TypeOrmModule.forFeature([InventoryItem, InventoryCategory])],
    providers: [InventoryService],
    controllers: [InventoryController],
})
export class InventoryModule {}
