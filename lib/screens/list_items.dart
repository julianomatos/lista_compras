// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:lista_compras/routes/routes_path.dart';
import '../components/footer.dart';
import '../models/shopping_item.dart';
import '../providers/item_provider.dart';
import '../utils/data_utils.dart';
import 'package:provider/provider.dart';

class ListItems extends StatefulWidget {
  const ListItems({super.key});

  @override
  State<ListItems> createState() => _ListItemState();
}

class _ListItemState extends State<ListItems> {
  @override
  Widget build(BuildContext context) {
    return Consumer<ItemProvider>(
      builder: (context, itemProvider, _) {
        List<ShoppingItem> items = itemProvider.items;

        items.sort(
            (a, b) => a.isBought == b.isBought ? 0 : (a.isBought ? 1 : -1));

        return Scaffold(
          appBar: AppBar(
            title: const Text('Lista de Compras'),
          ),
          body: ListView.builder(
            itemCount: items.length,
            itemBuilder: (context, index) {
              final item = items[index];
              return Card(
                elevation: 8,
                margin: const EdgeInsets.symmetric(
                  vertical: 5,
                  horizontal: 10,
                ),
                child: ListTile(
                  title: item.isBought
                      ? Text(
                           '${item.name} - ${item.quantity} ${item.unit}.',
                          style: TextStyle(
                            decoration: TextDecoration.lineThrough,
                          ),
                        )
                      : Text('${item.name} - ${item.quantity} ${item.unit}.'),
                  subtitle: item.isBought 
                  ? Text(
                    // 'Última compra: R\$ ${item.price} em  ${DataUtils.formatDate(item.purchaseDate!)}',
                    item.price.toString(),
                     style: TextStyle(
                            decoration: TextDecoration.lineThrough,
                          ),
                    )
                    :  Text(
                       item.price.toString(),
                    // 'Última compra: R\$ ${item.price} em  ${DataUtils.formatDate(item.purchaseDate!)}'
                    ),
                  // subtitle: Text(DataUtils.formatDate(item.purchaseDate)),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(Icons.shopping_cart),
                        onPressed: () async {
                          final updatedItem = ShoppingItem(
                            name: item.name,
                            price: item.price,
                            brand: item.brand,
                            unit: item.unit,
                            quantity: item.quantity,
                            purchaseDate: DateTime.now(),
                            purchaseLocation: await DataUtils.getLocation(),
                            isBought: true,
                          );

                          itemProvider.editItem(index, updatedItem);
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.edit),
                        onPressed: () {
                          Navigator.of(context).pushNamed(
                            RoutePaths.ITEM_UPDATE_SCREEN,
                            arguments: index,
                          );
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () {
                          Navigator.of(context).pushNamed(
                            RoutePaths.ITEM_DELETE_SCREEN,
                            arguments: index,
                          );
                        },
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
          floatingActionButton: FloatingActionButton(
            child: Icon(Icons.add),
            onPressed: () {
              // Abra a tela de criação de tarefa
              Navigator.of(context).pushNamed(RoutePaths.ITEM_ADD_SCREEN);
            },
          ),
          bottomNavigationBar: Footer(),
        );
      },
    );
  }
}
