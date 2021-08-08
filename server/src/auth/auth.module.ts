import { JwtStrategy } from './guards/jwt.strategy';
import { JwtGuard } from './guards/jwt.guard';
import { User } from './models/user.entity';
import { TypeOrmModule } from '@nestjs/typeorm';
import { Module } from '@nestjs/common';
import { AuthService } from './services/auth.service';
import { AuthController } from './controllers/auth.controller';
import { Group } from './models/group.entity';
import { JwtModule } from '@nestjs/jwt';

@Module({
    imports: [
        JwtModule.registerAsync({
            useFactory: () => ({
                secret: process.env.JWT_SECRET,
                signOptions: { expiresIn: '3600s' },
            }),
        }),
        TypeOrmModule.forFeature([User, Group]),
    ],
    providers: [AuthService, JwtGuard, JwtStrategy],
    controllers: [AuthController],
})
export class AuthModule {}
