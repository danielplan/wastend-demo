import { Validator } from './../../validator';
import { InventoryItem } from './../../inventory/models/item.entity';
import { User } from './user.entity';
import { ApiProperty } from '@nestjs/swagger';
import { PrimaryGeneratedColumn, OneToMany, Entity, Column } from 'typeorm';
import { HttpStatus } from '@nestjs/common';

@Entity('group')
export class Group {
    @PrimaryGeneratedColumn()
    id: number;

    @Column()
    @ApiProperty({
        description: 'The name of the group',
        type: String,
    })
    name: string;

    @OneToMany(() => User, (userEntity) => userEntity.group)
    @ApiProperty({
        description: 'The group members of a group',
        type: () => [User],
    })
    members: User[];

    @OneToMany(() => InventoryItem, (inventoryItem) => inventoryItem.group)
    @ApiProperty({
        description: 'The inventory items of a group',
        type: () => [InventoryItem],
    })
    inventoryItems: InventoryItem[];

    static validate(group: Group): void {
        const validation: Validator = new Validator();
        validation.assertExists('name', group.name);
        validation.throwErrors(HttpStatus.BAD_REQUEST);
    }
}
