import { User } from './../models/user.entity';
import { Controller, Post, Body } from '@nestjs/common';
import { AuthService } from '../services/auth.service';
import { ApiBody } from '@nestjs/swagger';

@Controller('auth')
export class AuthController {
    constructor(private readonly authService: AuthService) {}

    @Post('register')
    @ApiBody({ type: User })
    register(@Body() user: User): Promise<User> {
        return this.authService.registerAccount(user);
    }
}
