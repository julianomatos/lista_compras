// ignore_for_file: unused_import

import 'package:flutter/foundation.dart';
import '../models/shopping_item.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../services/items_service.dart';

class ItemProviderFB with ChangeNotifier {
  final List<ShoppingItem> _items = [];
  Future<List<ShoppingItem>> listItems() async {
    ItemsService itemsService = ItemsService();
    List<ShoppingItem> items = await itemsService.list();
    return items;
  }

  // List<ShoppingItem> get items => _items;
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
