import { Controller, Get } from '@nestjs/common';

@Controller('stuff')
export class StuffController {
    @Get()
    getTest() {
        return 'test';
    }
}
