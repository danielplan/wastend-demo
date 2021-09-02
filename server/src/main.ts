import { NestFactory } from '@nestjs/core';
import { DocumentBuilder, SwaggerModule } from '@nestjs/swagger';
import { AppModule } from './app.module';

async function bootstrap() {
    const app = await NestFactory.create(AppModule);
    app.enableCors();
    app.setGlobalPrefix('api');

    const config = new DocumentBuilder()
        .setTitle('wastend API')
        .setDescription('API routes for wastend')
        .setVersion('1.0.0')
        .addBasicAuth(
            { type: 'apiKey', in: 'header', name: 'Authorization' },
            'JWT',
        )
        .build();
    const document = SwaggerModule.createDocument(app, config);
    SwaggerModule.setup('/', app, document);

    await app.listen(process.env.PORT);
}
bootstrap();
