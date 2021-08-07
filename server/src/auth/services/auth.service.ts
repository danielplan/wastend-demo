import { Validator } from './../../validator';
import { User } from './../models/user.entity';
import { HttpStatus, Injectable, HttpException } from '@nestjs/common';
import * as bcrypt from 'bcrypt';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';

@Injectable()
export class AuthService {
    constructor(
        @InjectRepository(User)
        private readonly userRepository: Repository<User>,
    ) {}

    hashPassword(password: string): Promise<string> {
        return bcrypt.hash(password, 12);
    }

    async getUserById(id: number): Promise<User> {
        return this.userRepository.findOneOrFail(id);
    }

    async registerAccount(user: User): Promise<User> {
        //check input
        const validationResult: Validator = User.validate(user);
        if (validationResult.hasErrors()) {
            throw new HttpException(
                validationResult.getErrors(),
                HttpStatus.BAD_REQUEST,
            );
        }

        //check if already exists
        const alreadyExists = (await this.getUserById(user.id)) === undefined;
        if (alreadyExists) {
            throw new HttpException(
                Validator.getErrorsString(['This user already exists']),
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
}
