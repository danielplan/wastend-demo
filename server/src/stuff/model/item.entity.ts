import { Column, Entity, PrimaryGeneratedColumn } from "typeorm";

@Entity('stuff_item')
export class StuffItemEntity {
    @PrimaryGeneratedColumn()
    id: number;

    @Column({default: ''})
    name: string;

    @Column({default: 0})
    amount: 0;

}