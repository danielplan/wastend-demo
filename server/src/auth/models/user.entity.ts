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

    static validate(user: User): null | string {
        if (!user.username || user.username.length < 3) {
            return 'Username has to be at least 3 characters long.';
        }

        if (!user.displayName || user.displayName.length < 1) {
            return 'A displayname must be given.';
        }

        if (!user.password || user.password.length < 6) {
            return 'The password must be at least 6 characters long.';
        }
        return null;
    }
}
