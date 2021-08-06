import { InventoryController } from './controllers/inventory.controller';
import { TypeOrmModule } from '@nestjs/typeorm';
import { Module } from '@nestjs/common';
import { InventoryService } from './services/inventory.service';
import { InventoryItemEntity } from './models/item.entity';

@Module({
    imports: [TypeOrmModule.forFeature([InventoryItemEntity])],
    providers: [InventoryService],
    controllers: [InventoryController],
})
export class InventoryModule {}
