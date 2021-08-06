import { ApiProperty } from '@nestjs/swagger';
import { Column, Entity, PrimaryGeneratedColumn } from 'typeorm';

@Entity('inventory_item')
export class InventoryItemEntity {
    @PrimaryGeneratedColumn()
    id: number;

    @Column({ default: '' })
    @ApiProperty({
        description: 'Name that describes the inventory item',
        type: String,
    })
    name: string;

    @Column({ default: 0 })
    @ApiProperty({
        description: 'Starting inventory amount',
        type: Number,
    })
    amount: number;
}
