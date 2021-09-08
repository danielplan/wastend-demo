import { ItemCategory } from './category.entity';
import { Validator } from './../../validator';
import { Group } from '../../group/models/group.entity';
import { ApiProperty } from '@nestjs/swagger';
import { Column, Entity, PrimaryGeneratedColumn, ManyToOne } from 'typeorm';
import { HttpStatus } from '@nestjs/common';

@Entity('inventory_item')
export class InventoryItem {
    @PrimaryGeneratedColumn()
    id: number;

    @Column()
    @ApiProperty({
        description: 'Name that describes the inventory item',
        type: String,
    })
    name: string;

    @Column('decimal', { precision: 5, scale: 2 })
    @ApiProperty({
        description: 'Amount of the item in the inventory',
        type: Number,
    })
    amount: number;

    @Column()
    @ApiProperty({
        description: 'Unit for the amount',
        type: String,
    })
    unit: string;

    @Column('decimal', { precision: 5, scale: 2 })
    @ApiProperty({
        description: 'Minimum amount',
        type: Number,
    })
    minimumAmount?: number;

    @Column()
    @ApiProperty({
        description: 'To buy',
        type: Boolean,
    })
    toBuy?: boolean;

    @ManyToOne(() => ItemCategory, (category) => category.inventoryItems)
    @ApiProperty({
        description: 'The category of the inventory item',
        type: () => ItemCategory,
    })
    category?: ItemCategory;

    @ManyToOne(() => Group, (groupEntity) => groupEntity.inventoryItems)
    @ApiProperty({
        description: 'The group the item belongs to',
        type: () => Group,
    })
    group: Group;

    static validate(item: InventoryItem): void {
        const validation: Validator = new Validator();
        validation.assertExists('name', item.name);
        validation.assertGreaterOrEqualTo('amount', item.amount, 0);
        validation.assertExists('unit', item.unit);
        validation.throwErrors(HttpStatus.BAD_REQUEST);
    }
}
