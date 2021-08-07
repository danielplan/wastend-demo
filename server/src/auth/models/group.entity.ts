import { InventoryItem } from './../../inventory/models/item.entity';
import { User } from './user.entity';
import { ApiProperty } from '@nestjs/swagger';
import { PrimaryGeneratedColumn, OneToMany, Entity } from 'typeorm';

@Entity('group')
export class Group {
    @PrimaryGeneratedColumn()
    id: number;

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
}
