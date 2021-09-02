import { Module } from '@nestjs/common';
import { ConfigModule } from '@nestjs/config';
import { TypeOrmModule } from '@nestjs/typeorm';
import { AppController } from './app.controller';
import { AppService } from './app.service';
import { InventoryModule } from './inventory/inventory.module';
import { AuthModule } from './auth/auth.module';
import { GroupModule } from './group/group.module';

@Module({
    imports: [
        ConfigModule.forRoot({
            isGlobal: true,
        }),
        TypeOrmModule.forRoot({
            type: 'mysql',
            database: process.env.DB_DATABASE,
            password: process.env.DB_PASSWORD,
            username: process.env.DB_USERNAME,
            port: Number.parseInt(process.env.DB_PORT),
            host: process.env.DB_HOST,
            autoLoadEntities: true,
            entities: [__dirname + '/**/*.entity{.ts,.js}'],
            synchronize: process.env.DB_SYNCHRONIZE == 'true',
        }),
        InventoryModule,
        AuthModule,
        GroupModule,
    ],
    controllers: [AppController],
    providers: [AppService],
})
export class AppModule {}
