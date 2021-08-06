import { ApiProperty } from '@nestjs/swagger';
import { Column, ManyToOne, PrimaryGeneratedColumn } from 'typeorm';
import { GroupEntity } from './group.entity';

export class UserEntity {
    @PrimaryGeneratedColumn()
    id: number;

    @ApiProperty()
    @Column()
    username: string;

    @ApiProperty()
    @Column()
    email: string;

    @ApiProperty()
    @ManyToOne(() => GroupEntity, (groupEntity) => groupEntity.members)
    group: GroupEntity;
}
