import { Validator } from './../../validator';
import { ApiProperty } from '@nestjs/swagger';
import { Column, ManyToOne, PrimaryGeneratedColumn, Entity } from 'typeorm';
import { Group } from '../../group/models/group.entity';
import { HttpStatus } from '@nestjs/common';

@Entity('user')
export class User {
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
        description: 'Hashed password for login of the user',
        type: String,
    })
    password: string;

    @Column()
    @ApiProperty({
        description: 'the name with which the user is displayed',
        type: String,
    })
    displayName: string;

    @ManyToOne(() => Group, (groupEntity) => groupEntity.members)
    @ApiProperty({
        description: 'The group the user belongs to',
        type: () => Group,
    })
    group?: Group;

    assertIsInGroup?() {
        if (!this.group) {
            Validator.throwErrors(
                ['You are not in a group'],
                HttpStatus.NOT_FOUND,
            );
        }
    }

    static validate(user: User, isUpdate?: boolean): void {
        const validation: Validator = new Validator();
        validation.assertLength('username', user.username, 3);
        validation.assertRegex(
            'username',
            'can only contain letters and numbers',
            user.username,
            new RegExp('^[A-Za-z0-9]{3,}$'),
        );
        if (!isUpdate) {
            validation.assertLength('password', user.password, 6);
            validation.assertRegex(
                'password',
                "can't contain spaces",
                user.password,
                new RegExp('^[^\\s]{6,}$'),
            );
        }
        validation.assertExists('displayName', user.displayName);
        validation.throwErrors(HttpStatus.BAD_REQUEST);
    }
}
