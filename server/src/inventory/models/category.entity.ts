import { Validator } from './../../validator';
import { ApiProperty } from '@nestjs/swagger';
import { Column, Entity, PrimaryGeneratedColumn, OneToMany } from 'typeorm';
import { HttpStatus } from '@nestjs/common';
import { InventoryItem } from './item.entity';

@Entity('item_category')
export class ItemCategory {
    @PrimaryGeneratedColumn()
    id: number;

    @Column()
    @ApiProperty({
        description: 'Name that describes the category of the inventory item',
        type: String,
    })
    name: string;

    @OneToMany(() => InventoryItem, (inventoryItem) => inventoryItem.category)
    @ApiProperty({
        description: 'The inventory items of a group',
        type: () => [InventoryItem],
    })
    inventoryItems: InventoryItem[];

    static validate(category: ItemCategory): void {
        const validator: Validator = new Validator();
        validator.assertExists('name', category.name);
        validator.throwErrors(HttpStatus.NOT_FOUND);
    }
}
