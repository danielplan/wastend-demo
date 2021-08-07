import { User } from './models/user.entity';
import { TypeOrmModule } from '@nestjs/typeorm';
import { Module } from '@nestjs/common';
import { AuthService } from './services/auth.service';
import { AuthController } from './controllers/auth.controller';
import { Group } from './models/group.entity';

@Module({
    imports: [TypeOrmModule.forFeature([User, Group])],
    providers: [AuthService],
    controllers: [AuthController],
})
export class AuthModule {}
