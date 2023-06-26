import 'package:flutter/foundation.dart';
import '../models/shopping_item.dart';

class ItemProvider with ChangeNotifier {
  final List<ShoppingItem> _items = [];

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
