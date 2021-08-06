import { GroupEntity } from './../../auth/models/group.entity';
import { ApiProperty } from '@nestjs/swagger';
import {
    Column,
    Entity,
    PrimaryGeneratedColumn,
    OneToMany,
    ManyToOne,
} from 'typeorm';

@Entity('inventory_item')
export class InventoryItemEntity {
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

    @ManyToOne(() => GroupEntity, (groupEntity) => groupEntity.inventoryItems)
    @ApiProperty({
        description: 'The group the item belongs to',
        type: () => GroupEntity,
    })
    group: GroupEntity;
}
