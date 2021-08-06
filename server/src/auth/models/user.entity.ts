import { ApiProperty } from '@nestjs/swagger';
import { Column, ManyToOne, PrimaryGeneratedColumn, Entity } from 'typeorm';
import { GroupEntity } from './group.entity';

@Entity('user')
export class UserEntity {
    @PrimaryGeneratedColumn()
    id: number;

    @Column({ unique: true })
    @ApiProperty({
        description: 'Username that identifies a user',
        type: String,
    })
    username: string;

    @Column({ select: false })
    @ApiProperty({
        description: 'Password for login of the user',
        type: String,
    })
    password: string;

    @ManyToOne(() => GroupEntity, (groupEntity) => groupEntity.members)
    @ApiProperty({
        description: 'The group the user belongs to',
        type: () => GroupEntity,
    })
    group?: GroupEntity;
}
