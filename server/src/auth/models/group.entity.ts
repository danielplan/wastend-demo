import { UserEntity } from './user.entity';
import { ApiProperty } from '@nestjs/swagger';
import { PrimaryGeneratedColumn, OneToMany } from 'typeorm';

export class GroupEntity {
    @PrimaryGeneratedColumn()
    id: number;

    @ApiProperty()
    @OneToMany(() => UserEntity, (userEntity) => userEntity.group)
    members: UserEntity[];
}
