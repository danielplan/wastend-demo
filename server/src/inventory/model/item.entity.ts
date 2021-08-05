import { ApiProperty } from '@nestjs/swagger';
import { Column, Entity, PrimaryGeneratedColumn } from 'typeorm';

@Entity('stuff_item')
export class InventoryItemEntity {
    @ApiProperty()
    @PrimaryGeneratedColumn()
    id: number;

    @Column({ default: '' })
    @ApiProperty({
        description: 'String',
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
