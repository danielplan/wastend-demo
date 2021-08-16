import { Validator } from './../../validator';
import { User } from './../models/user.entity';
import { HttpStatus, Injectable } from '@nestjs/common';
import * as bcrypt from 'bcrypt';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { JwtService } from '@nestjs/jwt';

@Injectable()
export class AuthService {
    constructor(
        @InjectRepository(User)
        private readonly userRepository: Repository<User>,
        private jwtService: JwtService,
    ) {}

    hashPassword(password: string): Promise<string> {
        return bcrypt.hash(password, 12);
    }

    async registerAccount(user: User): Promise<{ token: string }> {
        //check input
        User.validate(user);

        //check if already exists
        const alreadyExists =
            (await this.userRepository.findOne({ username: user.username })) !==
            undefined;
        if (alreadyExists) {
            Validator.throwErrors(
                ['This user already exists'],
                HttpStatus.CONFLICT,
            );
        }
        //create user
        const hashedPassword: string = await this.hashPassword(user.password);

        delete user.group;
        const newUser: User = await this.userRepository.save({
            ...user,
            password: hashedPassword,
        });
        return this.createToken(newUser.id);
    }

    async validateLogin(username: string, password: string): Promise<User> {
        const user: User = await this.userRepository.findOne(
            { username },
            {
                select: ['id', 'password'],
            },
        );

        if (user === undefined) {
            Validator.throwErrors(
                ['User with that username not found'],
                HttpStatus.NOT_FOUND,
            );
        }

        const passwordCorrect: boolean = await bcrypt.compare(
            password,
            user.password,
        );
        if (!passwordCorrect) {
            Validator.throwErrors(
                ['This password was not correct'],
                HttpStatus.NOT_FOUND,
            );
        }

        delete user.password;
        return user;
    }

    async login(user: User): Promise<{ token: string }> {
        const { username, password } = user;
        user = await this.validateLogin(username, password);
        return this.createToken(user.id);
    }

    async createToken(userId: number): Promise<{ token: string }> {
        const token: string = await this.jwtService.signAsync({
            user: {
                id: userId,
            },
        });
        return { token };
    }

    async getUserData(id: number): Promise<User> {
        const user: User = await this.userRepository.findOne(id);
        if (user === undefined) {
            Validator.throwNotFound();
        }
        return user;
    }

    async updateUser(newUser: User, currentUserId: number): Promise<User> {
        const currUser: User = await this.userRepository.findOne(currentUserId);
        User.validate(newUser, !newUser.password);
        console.log(newUser);

        delete newUser.group;
        delete newUser.id;
        if (!newUser.password) {
            delete newUser.password;
        } else {
            newUser.password = await this.hashPassword(newUser.password);
        }

        newUser = {
            ...currUser,
            ...newUser,
        };
        console.log(newUser);

        this.userRepository.update(currUser.id, newUser);
        return newUser;
    }
}
