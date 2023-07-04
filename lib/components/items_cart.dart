import '../models/shopping_item.dart';
import '../services/items_service.dart';
import 'package:flutter/material.dart';

import '../components/items.dart';

class ItemsCart extends StatelessWidget {
  const ItemsCart({Key? key});

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
            final purchasedItems =
                list.where((item) => item.isBought).toList();
            if (purchasedItems.isNotEmpty) {
              return Expanded(
                child: ListView(
                  children: generateListProduct(purchasedItems),
                ),
              );
            } else {
              return const Center(
                child: Text('Carrinho Vazio.'),
              );
            }
          } else {
            return const Center(
              child: Text('Sem itens na lista.'),
            );
          }
        } else {
          return const Center(
            child: Text('Sem itens na lista.'),
          );
        }
      },
    );
  }
}
