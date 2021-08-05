import { StuffController } from './controllers/stuff.controller';
import { TypeOrmModule } from "@nestjs/typeorm";
import { Module } from "@nestjs/common";
import { StuffService } from "./services/stuff.service";
import { StuffItemEntity } from "./model/item.entity";

@Module({
  imports: [TypeOrmModule.forFeature([StuffItemEntity])],
  providers: [StuffService],
  controllers: [StuffController]
})
export class StuffModule {}
