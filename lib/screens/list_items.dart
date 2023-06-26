
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
                  vertical: 10,
                  horizontal: 10,
                ),
                child: ListTile(
                  title: Text(item.name),
                  subtitle: Text('${item.quantity} -  ${item.unit}'),
                  // subtitle: Text(DataUtils.formatDate(item.purchaseDate)),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
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
