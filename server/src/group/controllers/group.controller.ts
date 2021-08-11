import { ApiBasicAuth, ApiOperation, ApiParam } from '@nestjs/swagger';
import { Group } from './../models/group.entity';
import { GroupService } from './../services/group.service';
import {
    Controller,
    Param,
    Put,
    UseGuards,
    Request,
    Get,
    Post,
    Body,
} from '@nestjs/common';
import { JwtGuard } from 'src/auth/guards/jwt.guard';

@Controller('group')
export class GroupController {
    constructor(private readonly groupService: GroupService) {}

    @Get()
    @ApiOperation({
        summary: 'List the data of your current group',
        tags: ['Group'],
    })
    @UseGuards(JwtGuard)
    @ApiBasicAuth('JWT')
    getData(@Request() req): Promise<Group> {
        return this.groupService.getGroupData(req.user);
    }

    @Post()
    @ApiOperation({
        summary: 'Creates a new group and adds you to it',
        tags: ['Group'],
    })
    @UseGuards(JwtGuard)
    @ApiBasicAuth('JWT')
    create(@Body() group: Group, @Request() req): Promise<Group> {
        return this.groupService.createGroupAndJoin(group, req.user);
    }

    @Put('add/:username')
    @ApiOperation({
        summary: 'Adds the given user to your current group',
        tags: ['Group'],
    })
    @UseGuards(JwtGuard)
    @ApiBasicAuth('JWT')
    @ApiParam({ name: 'username', type: String })
    addUser(
        @Param('username') username: string,
        @Request() req,
    ): Promise<Group> {
        return this.groupService.addUserToGroup(username, req.user);
    }
}
