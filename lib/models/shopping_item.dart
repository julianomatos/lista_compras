class ShoppingItem {
  String name;
  double price;
  String observation;
  String unit;
  int quantity;
  DateTime? purchaseDate;
  String? purchaseLocation;
  bool isBought;

  ShoppingItem({
    required this.name,
    required this.price,
    required this.observation,
    required this.unit,
    required this.quantity,
    this.purchaseDate,
    this.purchaseLocation,
    required this.isBought,
  });
}
