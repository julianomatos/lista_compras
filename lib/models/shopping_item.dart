class ShoppingItem {
  String name;
  double price;
  String brand;
  String unit;
  int quantity;
  DateTime purchaseDate;
  String purchaseLocation;
  bool isBought;

  ShoppingItem({
    required this.name,
    required this.price,
    required this.brand,
    required this.unit,
    required this.quantity,
    required this.purchaseDate,
    required this.purchaseLocation,
    required this.isBought,
  });
}
