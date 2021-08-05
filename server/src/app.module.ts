import { Module } from "@nestjs/common";
import { ConfigModule } from "@nestjs/config";
import { TypeOrmModule } from "@nestjs/typeorm";
import { AppController } from "./app.controller";
import { AppService } from "./app.service";
import { StuffModule } from './stuff/stuff.module';

@Module({
  imports: [
    ConfigModule.forRoot({
      isGlobal: true,
    }),
    TypeOrmModule.forRoot({
      type: "sqlite",
      database: `${process.env.SQLITE_DATABASE}.sqlite`,
      autoLoadEntities: true,
      entities: [__dirname + "/**/*.entity{.ts,.js}"],
      synchronize: true,
    }),
    StuffModule,
  ],
  controllers: [AppController],
  providers: [AppService],
})
export class AppModule {}
