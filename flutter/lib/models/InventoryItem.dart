class InventoryItem {
  int? id;
  String name;
  double amount;
  String unit;
  int? categoryId;

  InventoryItem({this.id, required this.name, required this.amount, required this.unit, this.categoryId});
}
