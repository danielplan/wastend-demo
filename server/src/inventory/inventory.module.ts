import { InventoryController } from './controllers/inventory.controller';
import { TypeOrmModule } from '@nestjs/typeorm';
import { Module } from '@nestjs/common';
import { StuffService } from './services/inventory.service';
import { InventoryItemEntity } from './model/item.entity';

@Module({
    imports: [TypeOrmModule.forFeature([InventoryItemEntity])],
    providers: [StuffService],
    controllers: [InventoryController],
})
export class InventoryModule {}
