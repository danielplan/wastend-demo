import { Group } from './group.interface';

export interface User {
    id: number;
    group?: Group;
    username: string;
    password: string;
}
