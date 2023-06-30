// ignore_for_file: use_key_in_widget_constructors

import '../models/shopping_item.dart';
import '../services/items_service.dart';
import 'package:flutter/material.dart';

import '../components/items.dart';

class ItemsList extends StatelessWidget {
  const ItemsList({super.key});
  
  @override
  Widget build(BuildContext context) {
    List<Widget> generateListProduct(List<ShoppingItem> items) {
      return items.map((item) => Item(item)).toList();
    }

    return FutureBuilder<List<ShoppingItem>>(
        future: ItemsService().list(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Erro ao consultar dados ${snapshot.error}'),
            );
          } else if (snapshot.hasData) {
            final list = snapshot.data;
            if (list != null && list.isNotEmpty) {
              return Expanded(
                child: ListView(
                  children: generateListProduct(list),
                ),
              );
            } else {
              return const Center(
                child: Text('Nenhum item cadastrado.'),
              );
            }
          } else {
            return const Center(
              child: Text('Nenhum item cadastrado.'),
            );
          }
        });
  }
}
