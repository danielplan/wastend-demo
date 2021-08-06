import { UserEntity } from './../models/user.entity';
import { User } from './../models/user.interface';
import { Observable, switchMap } from 'rxjs';
import { Injectable } from '@nestjs/common';
import * as bcrypt from 'bcrypt';
import { from } from 'rxjs';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { map } from 'rxjs';

@Injectable()
export class AuthService {
    constructor(
        @InjectRepository(UserEntity)
        private readonly userRepository: Repository<UserEntity>,
    ) {}

    hashPassword(password: string): Observable<string> {
        return from(bcrypt.hash(password, 12));
    }

    registerAccount(user: User): Observable<User> {
        const { password } = user;
        return this.hashPassword(password).pipe(
            switchMap((hashedPassword: string) => {
                return from(
                    this.userRepository.save({
                        ...user,
                        password: hashedPassword,
                    }),
                ).pipe(
                    map((user: User) => {
                        delete user.password;
                        return user;
                    }),
                );
            }),
        );
    }
}
