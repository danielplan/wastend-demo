import { StuffService } from './../services/stuff.service';
import { Body, Controller, Get, Post } from '@nestjs/common';
import { StuffItem } from '../model/item.interface';

@Controller('stuff')
export class StuffController {

    constructor(private stuffService: StuffService) {}

    @Post('item')
    addStuffItem(@Body() stuffItem: StuffItem) {
        this.stuffService.addStuffItem(stuffItem);
    }
}
