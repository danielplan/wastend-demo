import { Validator } from './../../validator';
import { Group } from './../../auth/models/group.entity';
import { ApiProperty } from '@nestjs/swagger';
import { Column, Entity, PrimaryGeneratedColumn, ManyToOne } from 'typeorm';

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

    @Column({ default: 0 })
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

    @ManyToOne(() => Group, (groupEntity) => groupEntity.inventoryItems)
    @ApiProperty({
        description: 'The group the item belongs to',
        type: () => Group,
    })
    group: Group;

    static validate(item: InventoryItem): Validator {
        const validation: Validator = new Validator();
        validation.assertExists('unit', item.unit);
        validation.assertGreaterThan('amout', item.amount, 0);
        validation.assertExists('name', item.name);
        return validation;
    }
}
