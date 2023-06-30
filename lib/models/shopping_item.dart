import 'package:cloud_firestore/cloud_firestore.dart';

class ShoppingItem {
  String? id;
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

  ShoppingItem.fromJson(String this.id, Map<String, dynamic> json)
      : name = json['name'],
        price = json['price'],
        observation = json['observation'],
        unit = json['unit'],
        purchaseDate = (json['purchaseDate'] as Timestamp).toDate(),
        quantity = json['quantity'],
        purchaseLocation = json['purchaseLocation'],
        isBought = json['isBought'];

  Map<String, dynamic> toJson() => {
        'name': name,
        'price': price,
        'observation': observation,
        'unit': unit,
        'quantity': quantity,
        'purchaseDate': purchaseDate,
        'purchaseLocation': purchaseLocation,
        'isBought': isBought,
      };
}
