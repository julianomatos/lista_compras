// ignore_for_file: unused_import

import 'package:flutter/foundation.dart';
import '../models/shopping_item.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ItemProvider with ChangeNotifier {
  final List<ShoppingItem> _items = [
    // ShoppingItem(
    //   name: 'Produto 1',
    //   price: 10.0,
    //   observation: '',
    //   unit: 'un',
    //   quantity: 2,
    //   purchaseDate: DateTime.now(),
    //   purchaseLocation: '',
    //   isBought: false,
    // ),
    // ShoppingItem(
    //   name: 'Produto 2',
    //   price: 15.0,
    //   observation: '', unit: 'un',
    //   quantity: 3,
    //   purchaseDate: DateTime.now(),
    //   purchaseLocation: '',
    //   isBought: true,
    // ),
    // ShoppingItem(
    //   name: 'Produto 3',
    //   price: 20.0,
    //   observation: '', unit: 'un',
    //   quantity: 1,
    //   purchaseDate: DateTime.now(),
    //   purchaseLocation: '',
    //   isBought: false,
    // ),
    // ShoppingItem(
    //   name: 'Produto 4',
    //   price: 12.5,
    //   observation: '', unit: 'un',
    //   quantity: 4,
    //   purchaseDate: DateTime.now(),
    //   purchaseLocation: '',
    //   isBought: false,
    // ),
    // ShoppingItem(
    //   name: 'Produto 5',
    //   price: 8.0,
    //   observation: '', unit: 'un',
    //   quantity: 2,
    //   purchaseDate: DateTime.now(),
    //   purchaseLocation: '',
    //   isBought: true,
    // ),
  ];

  List<ShoppingItem> get items => _items;

  void addItem(ShoppingItem item) {
    _items.add(item);
    notifyListeners();
  }

  void editItem(int index, ShoppingItem item) {
    _items[index] = item;
    notifyListeners();
  }

  void deleteItem(int index) {
    _items.removeAt(index);
    notifyListeners();
  }

  ShoppingItem showItem(int index) {
    return _items[index];
  }
}
