import { Validator } from './../../validator';
import { Group } from './../../auth/models/group.entity';
import { ApiProperty } from '@nestjs/swagger';
import { Column, Entity, PrimaryGeneratedColumn, ManyToOne } from 'typeorm';

@Entity('inventory_category')
export class InventoryCategory {
    @PrimaryGeneratedColumn()
    id: number;
}
