import { User } from './../models/user.entity';
import { Controller, Post, Body } from '@nestjs/common';
import { AuthService } from '../services/auth.service';
import { ApiBody, ApiOperation } from '@nestjs/swagger';

@Controller('auth')
export class AuthController {
    constructor(private readonly authService: AuthService) {}

    @Post('register')
    @ApiBody({ type: User })
    @ApiOperation({ summary: 'Creates a new user if possible', tags: ['Auth'] })
    register(@Body() user: User): Promise<User> {
        return this.authService.registerAccount(user);
    }
}
