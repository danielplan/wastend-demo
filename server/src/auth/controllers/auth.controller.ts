import { UserEntity } from './../models/user.entity';
import { Observable } from 'rxjs';
import { User } from './../models/user.interface';
import { Controller, Post, Body } from '@nestjs/common';
import { AuthService } from '../services/auth.service';
import { ApiBody } from '@nestjs/swagger';

@Controller('auth')
export class AuthController {
    constructor(private readonly authService: AuthService) {}

    @Post('register')
    @ApiBody({ type: UserEntity })
    register(@Body() user: User): Observable<User> {
        return this.authService.registerAccount(user);
    }
}
