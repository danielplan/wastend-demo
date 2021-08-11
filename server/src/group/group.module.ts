import { User } from 'src/auth/models/user.entity';
import { Group } from './models/group.entity';
import { TypeOrmModule } from '@nestjs/typeorm';
import { Module } from '@nestjs/common';
import { GroupService } from './services/group.service';
import { GroupController } from './controllers/group.controller';

@Module({
    imports: [TypeOrmModule.forFeature([Group, User])],
    providers: [GroupService],
    controllers: [GroupController],
})
export class GroupModule {}
