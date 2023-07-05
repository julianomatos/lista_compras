import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

import '../models/shopping_item.dart';
import '../services/items_service.dart';
import '../components/items.dart';

class ItemsList extends StatelessWidget {
  const ItemsList({Key? key});

  @override
  Widget build(BuildContext context) {
    List<Widget> generateListProduct(List<ShoppingItem> items) {
      return items.map((item) => Item(item)).toList();
    }

    return Consumer<ItemsService>(
      builder: (context, itemsService, _) {
        return FutureBuilder<List<ShoppingItem>>(
          future: itemsService.list(),
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
                final notPurchasedItems =
                    list.where((item) => !item.isBought).toList();
                final purchasedItems =
                    list.where((item) => item.isBought).toList();

                return Flexible(
                  child: ListView.separated(
                    itemCount: notPurchasedItems.length + purchasedItems.length + 1,
                    itemBuilder: (context, index) {
                      if (index < notPurchasedItems.length) {
                        return Item(notPurchasedItems[index]);
                      } else if (index == notPurchasedItems.length) {
                        return const Center(child:  Text('Carrinho de compras')); 
                      } else {
                        return Item(purchasedItems[index - notPurchasedItems.length - 1]);
                      }
                    },
                    separatorBuilder: (context, index) {
                      if (index == notPurchasedItems.length - 1) {
                        return const Divider(); 
                      } else {
                        return const SizedBox.shrink();
                      }
                    },
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
          },
        );
      },
    );
  }
}
