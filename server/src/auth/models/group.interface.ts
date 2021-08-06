import { InventoryItem } from './../../inventory/models/item.interface';
import { User } from './user.interface';

export interface Group {
    id: number;
    members: User[];
    inventoryItems: InventoryItem[];
}
