import { Validator } from './../../validator';
import { ApiProperty } from '@nestjs/swagger';
import { Column, ManyToOne, PrimaryGeneratedColumn, Entity } from 'typeorm';
import { Group } from './group.entity';

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

    static validate(user: User): Validator {
        const validation: Validator = new Validator();
        validation.assertLength('username', user.username, 3);
        validation.assertLength('password', user.password, 6);
        validation.assertExists('displayname', user.displayName);
        return validation;
    }
}
