// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, unused_import

import 'package:flutter/material.dart';
import 'package:lista_compras/services/items_service.dart';
import 'package:provider/provider.dart';
import '../components/footer.dart';
import '../models/shopping_item.dart';
import '../providers/item_provider.dart';

class DeleteItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // int index = ModalRoute.of(context)!.settings.arguments as int;
     ShoppingItem item =
        ModalRoute.of(context)!.settings.arguments as ShoppingItem;
    String name = item.name;
    // String date = "";
    // return Consumer<ItemProvider>(
    //   builder: (context, itemProvider, _) {
    //     if (itemProvider.items.isNotEmpty) {
    //       ShoppingItem item = itemProvider.showItem(index);
    //       name = item.name;
    //       // date = task.date.toString().substring(0, 10);
    //     }
        return Scaffold(
          appBar: AppBar(
            title: const Text('Deletar Item'),
          ),
          body: Card(
            elevation: 10,
            margin: const EdgeInsets.symmetric(
              vertical: 20,
              horizontal: 20,
            ),
            child: SizedBox(
             
              height: 150,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      name,
                      style: TextStyle(fontSize: 20),
                    ),
                    // Text(
                    //   date,
                    //   style: TextStyle(fontSize: 16),
                    // ),
                  ],
                ),
              ),
            ),
          ),
          floatingActionButton: FloatingActionButton(
            child: const Icon(Icons.delete),
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: Text('Exclusão'),
                  content: Text('Tem certeza que deseja excluir? '),
                  actions: [
                    TextButton(
                      child: Text('SIM'),
                      onPressed: () {
                        ItemsService().delete(item.id!);
                        Navigator.pop(context);
                        Navigator.pop(context);
                      },
                    ),
                    TextButton(
                      child: Text('Não'),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ],
                ),
              );
            },
            //Navigator.pop(context);
          ),
          bottomNavigationBar: Footer(),
        );
      }
    // );
  // }
}
