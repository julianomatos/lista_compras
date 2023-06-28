// ignore_for_file: prefer_const_constructors, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:lista_compras/routes/routes_path.dart';
import 'package:lista_compras/utils/current_converter.dart';
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
  CurrentConverter currentConverter = CurrentConverter();

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
                  leading: !item.isBought ? IconButton(
                        icon: Icon(Icons.shopping_cart),
                        onPressed: () async {
                          TextEditingController priceController =
                              TextEditingController(
                                  text: item.price.toStringAsFixed(2));
                          TextEditingController quantityController =
                              TextEditingController(
                                  text: item.quantity.toString());
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text('Confirmar Compra'),
                                content: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    TextFormField(
                                      controller: priceController,
                                      decoration:
                                          InputDecoration(labelText: 'Preço'),
                                    ),
                                    SizedBox(height: 8),
                                    TextFormField(
                                      controller: quantityController,
                                      decoration: InputDecoration(
                                          labelText: 'Quantidade'),
                                    ),
                                  ],
                                ),
                                actions: [
                                  TextButton(
                                    child: Text('Cancelar'),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                  TextButton(
                                    child: Text('Confirmar'),
                                    onPressed: () async {
                                      final double updatedPrice =
                                          double.parse(priceController.text);
                                      final int updatedQuantity =
                                          int.parse(quantityController.text);
                                      final updatedItem = ShoppingItem(
                                        name: item.name,
                                        price: updatedPrice,
                                        observation: item.observation,
                                        unit: item.unit,
                                        quantity: updatedQuantity,
                                        purchaseDate: DateTime.now(),
                                        purchaseLocation:
                                            await DataUtils.getLocation(),
                                        isBought: true,
                                      );
                                      itemProvider.editItem(index, updatedItem);
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                ],
                              );
                            },
                          );
                        },
                      )
                      :
                      IconButton(
                        icon: Icon(Icons.remove_shopping_cart),
                        onPressed: ()  {
                          showDialog(
                            context: context, 
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text('Deseja remover do carrinho?'),
                                content: Text(item.name),
                                actions: [
                                  TextButton(
                                    child: Text('Cancelar'),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                  TextButton(
                                    child: Text('Confirmar'),
                                    onPressed: () {
                                        final updatedItem = ShoppingItem(
                                        name: item.name,
                                        price: item.price,
                                        observation: item.observation,
                                        unit: item.unit,
                                        quantity: item.quantity,
                                        isBought: false,
                                      );
                                      itemProvider.editItem(index, updatedItem);
                                       Navigator.of(context).pop();
                                    },
                                  ),
                                ],
                              );
                                
                                },);
                                    
                                    },
                      ),
                  title: item.isBought
                      ? Text(
                          item.name,
                          style: TextStyle(
                            decoration: TextDecoration.lineThrough,
                          ),
                        )
                      : Text(item.name),
                  subtitle: item.isBought
                      ? Text(
                          '${item.quantity} ${item.unit}. R\$ ${item.price.toStringAsFixed(2)}',
                        )
                      : Text(
                          'Susgestão: ${item.quantity} ${item.unit}.',
                        ),
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
