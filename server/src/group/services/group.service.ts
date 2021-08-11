import { InjectRepository } from '@nestjs/typeorm';
import { Validator } from './../../validator';
import { User } from 'src/auth/models/user.entity';
import { Repository } from 'typeorm';
import { HttpStatus, Injectable } from '@nestjs/common';
import { Group } from '../models/group.entity';

@Injectable()
export class GroupService {
    constructor(
        @InjectRepository(Group)
        private readonly groupRepository: Repository<Group>,
        @InjectRepository(User)
        private readonly userRepository: Repository<User>,
    ) {}

    async getGroupData(user: User): Promise<Group> {
        user = await this.userRepository.findOne(user.id, {
            relations: ['group'],
        });
        user.assertIsInGroup();

        const group: Group = await this.groupRepository.findOne(user.group.id, {
            relations: ['members'],
        });
        return group;
    }

    async addUserToGroup(username: string, user: User): Promise<Group> {
        user = await this.userRepository.findOne(user.id, {
            relations: ['group'],
        });
        user.assertIsInGroup();

        const addedUser: User = await this.userRepository.findOne({ username });
        if (addedUser === undefined) {
            Validator.throwErrors(
                ['No user with that username found'],
                HttpStatus.NOT_FOUND,
            );
        }
        if (addedUser.group) {
            Validator.throwErrors(
                ['This user is already in a group'],
                HttpStatus.BAD_REQUEST,
            );
        }

        this.userRepository.update(addedUser, {
            ...addedUser,
            group: user.group,
        });
        return user.group;
    }

    async createGroupAndJoin(group: Group, user: User): Promise<Group> {
        user = await this.userRepository.findOne(user.id, {
            relations: ['group'],
        });
        if (user.group) {
            Validator.throwErrors(
                ['You are already in a group'],
                HttpStatus.BAD_REQUEST,
            );
        }
        Group.validate(group);

        delete group.inventoryItems;
        delete group.members;

        group = {
            ...group,
            members: [user],
        };
        return this.groupRepository.save(group);
    }

    async updateGroup(newGroup: Group, user: User): Promise<Group> {
        user = await this.userRepository.findOne(user.id, {
            relations: ['group'],
        });
        user.assertIsInGroup();
        Group.validate(newGroup);
        const currentGroup: Group = await this.groupRepository.findOne(
            user.id,
            {
                relations: ['members'],
            },
        );
        delete newGroup.inventoryItems;
        delete newGroup.members;
        delete newGroup.id;

        newGroup = {
            ...user.group,
            ...newGroup,
        };
        this.groupRepository.update(currentGroup.id, newGroup);
        return newGroup;
    }

    async leaveGroup(user: User): Promise<Group> {
        user = await this.userRepository.findOne(user.id, {
            relations: ['group'],
        });
        user.assertIsInGroup();

        let group: Group = user.group;
        user.group = null;
        this.userRepository.update(user.id, user);
        group = await this.groupRepository.findOne(group.id, {
            relations: ['members'],
        });
        if (!group.members || group.members.length === 0) {
            await this.groupRepository.delete(group.id);
        }
        return group;
    }
}
