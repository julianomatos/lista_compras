// ignore_for_file: prefer_const_constructors, use_build_context_synchronously

import 'package:lista_compras/services/items_service.dart';
import 'package:provider/provider.dart';

import '../models/shopping_item.dart';
import 'package:flutter/material.dart';
import '../routes/routes_path.dart';
import '../utils/data_utils.dart';

class Item extends StatefulWidget {
  const Item(
    this.shoppingItem, {
    super.key,
  });

  final ShoppingItem shoppingItem;

  @override
  State<Item> createState() => _ItemState();
}

class _ItemState extends State<Item> {
  @override
  Widget build(BuildContext context) {
    // final items = Provider.of<ItemProvider>(context);
    return Consumer<ItemsService>(builder: (context, itemsService, _) {
      return Card(
        elevation: 5,
        margin: const EdgeInsets.symmetric(
          vertical: 5,
          horizontal: 10,
        ),
        child: ListTile(
          // contentPadding: const EdgeInsets.symmetric(vertical: 8),
          leading: !widget.shoppingItem.isBought
              ? IconButton(
                  icon: Icon(Icons.shopping_cart),
                  onPressed: () async {
                    TextEditingController priceController =
                        TextEditingController(
                            text:
                                widget.shoppingItem.price?.toStringAsFixed(2));
                    TextEditingController quantityController =
                        TextEditingController(
                            text: widget.shoppingItem.quantity.toString());
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
                                decoration: InputDecoration(labelText: 'Preço'),
                              ),
                              SizedBox(height: 8),
                              TextFormField(
                                controller: quantityController,
                                decoration:
                                    InputDecoration(labelText: 'Quantidade'),
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
                                  name: widget.shoppingItem.name,
                                  price: updatedPrice,
                                  observation: widget.shoppingItem.observation,
                                  unit: widget.shoppingItem.unit,
                                  quantity: updatedQuantity,
                                  purchaseDate: DateTime.now(),
                                  purchaseLocation:
                                      await DataUtils.getLocation(),
                                  isBought: true,
                                );
                                // items.editItem(index, updatedItem);

                                itemsService.update(
                                    widget.shoppingItem.id!, updatedItem);
                                Navigator.of(context).pop();
                              },
                            ),
                          ],
                        );
                      },
                    );
                  },
                )
              : IconButton(
                  icon: Icon(Icons.remove_shopping_cart),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text('Deseja remover do carrinho?'),
                          content: Text(widget.shoppingItem.name),
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
                                  name: widget.shoppingItem.name,
                                  price: widget.shoppingItem.price,
                                  observation: widget.shoppingItem.observation,
                                  unit: widget.shoppingItem.unit,
                                  purchaseDate: widget.shoppingItem.purchaseDate,
                                  purchaseLocation: widget.shoppingItem.purchaseLocation,
                                  quantity: widget.shoppingItem.quantity,
                                  isBought: false,
                                );
                                //  items.editItem(index, updatedItem);
                                itemsService.update(
                                    widget.shoppingItem.id!, updatedItem);
                                Navigator.of(context).pop();
                              },
                            ),
                          ],
                        );
                      },
                    );
                  },
                ),
          title: widget.shoppingItem.isBought
              ? Text(
                  widget.shoppingItem.name,
                  style: TextStyle(
                    decoration: TextDecoration.lineThrough,
                  ),
                )
              : Text(widget.shoppingItem.name),
          subtitle: widget.shoppingItem.isBought
              ? Text(
                  '${widget.shoppingItem.quantity} ${widget.shoppingItem.unit}. R\$ ${widget.shoppingItem.price?.toStringAsFixed(2)}',
                )
              : Text(
                  '${widget.shoppingItem.quantity} ${widget.shoppingItem.unit}.',
                ),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                icon: Icon(Icons.edit),
                onPressed: () {
                  Navigator.of(context).pushNamed(
                    RoutePaths.ITEM_UPDATE_SCREEN,
                    arguments: widget.shoppingItem,
                  );
                },
              ),
              IconButton(
                icon: Icon(Icons.delete),
                onPressed: () {
                  Navigator.of(context).pushNamed(
                    RoutePaths.ITEM_DELETE_SCREEN,
                    arguments: widget.shoppingItem,
                  );
                },
              ),
            ],
          ),
        ),
      );
    });
  }
}
