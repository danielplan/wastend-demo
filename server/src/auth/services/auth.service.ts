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

    async registerAccount(user: User): Promise<User> {
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
        const newUser: User = await this.userRepository.save({
            ...user,
            password: hashedPassword,
        });
        delete newUser.password;
        return newUser;
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
        const token: string = await this.jwtService.signAsync({
            user,
        });
        return {
            token,
        };
    }
}
