import { JwtGuard } from './../guards/jwt.guard';
import { User } from './../models/user.entity';
import {
    Controller,
    Post,
    Body,
    Get,
    Param,
    Request,
    UseGuards,
    Put,
} from '@nestjs/common';
import { AuthService } from '../services/auth.service';
import { ApiBody, ApiOperation, ApiParam, ApiBasicAuth } from '@nestjs/swagger';

@Controller('auth')
export class AuthController {
    constructor(private readonly authService: AuthService) {}

    @Post('register')
    @ApiBody({ type: User })
    @ApiOperation({ summary: 'Creates a new user if possible', tags: ['Auth'] })
    register(@Body() user: User): Promise<{ token: string }> {
        return this.authService.registerAccount(user);
    }

    @Post('login')
    @ApiBody({ type: User })
    @ApiOperation({ summary: 'Get a jwt token if successful', tags: ['Auth'] })
    login(@Body() user: User): Promise<{ token: string }> {
        return this.authService.login(user);
    }

    @Get(':id')
    @ApiParam({ name: 'id', type: Number })
    @ApiOperation({ summary: 'Get data of a user', tags: ['Auth'] })
    getData(@Param('id') id: number): Promise<User> {
        return this.authService.getUserData(id);
    }

    @Get()
    @UseGuards(JwtGuard)
    @ApiBasicAuth('JWT')
    @ApiOperation({ summary: 'Get current user data', tags: ['Auth'] })
    getCurrentData(@Request() req): Promise<User> {
        return this.authService.getUserData(req.user.id);
    }

    @Put()
    @UseGuards(JwtGuard)
    @ApiBasicAuth('JWT')
    @ApiOperation({ summary: 'Update current user data', tags: ['Auth'] })
    updateCurrentUser(@Body() user: User, @Request() req): Promise<User> {
        return this.authService.updateUser(user, req.user.id);
    }
}
