import { Validator } from '../../validator';
import { InventoryItem } from '../../inventory/models/item.entity';
import { User } from '../../auth/models/user.entity';
import { ApiProperty } from '@nestjs/swagger';
import { PrimaryGeneratedColumn, OneToMany, Entity } from 'typeorm';
import { HttpStatus } from '@nestjs/common';

@Entity('group')
export class Group {
    @PrimaryGeneratedColumn()
    id: number;

    @OneToMany(() => User, (user) => user.group)
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
        validation.throwErrors(HttpStatus.BAD_REQUEST);
    }
}
