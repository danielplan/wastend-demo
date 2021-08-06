import { InventoryItem } from './../../inventory/models/item.interface';
import { InventoryItemEntity } from './../../inventory/models/item.entity';
import { UserEntity } from './user.entity';
import { ApiProperty } from '@nestjs/swagger';
import { PrimaryGeneratedColumn, OneToMany, Entity } from 'typeorm';

@Entity('group')
export class GroupEntity {
    @PrimaryGeneratedColumn()
    id: number;

    @OneToMany(() => UserEntity, (userEntity) => userEntity.group)
    @ApiProperty({
        description: 'The group members of a group',
        type: () => [UserEntity],
    })
    members: UserEntity[];

    @OneToMany(
        () => InventoryItemEntity,
        (inventoryItem) => inventoryItem.group,
    )
    @ApiProperty({
        description: 'The inventory items of a group',
        type: () => [InventoryItemEntity],
    })
    inventoryItems: InventoryItem[];
}
