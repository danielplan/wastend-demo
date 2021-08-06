import { Group } from './../../auth/models/group.interface';
export interface InventoryItem {
    id: number;
    name: string;
    amount: number;
    unit: string;
    group: Group;
}
