
// ignore_for_file: prefer_const_constructors

import 'package:current_converter/current_converter.dart';
import 'package:flutter/material.dart';
import 'package:lista_compras/routes/routes_path.dart';
import '../components/cart_total.dart';
import '../components/items_list.dart';

class ListItemsScreen extends StatefulWidget {
  const ListItemsScreen({super.key});

  @override
  State<ListItemsScreen> createState() => _ListItemState();
}

class _ListItemState extends State<ListItemsScreen> {
  CurrentConverter currentConverter = CurrentConverter();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de Compras'),
      ),
      body:
          Column(
            children: const [
              Center(child: Text('Sugestão de compra')),
              ItemsList(),
            ],
          ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.of(context).pushNamed(RoutePaths.ITEM_ADD_SCREEN);
        },
      ),
      bottomNavigationBar: CartTotal(),
    );
  }
  // );
  // }
}
