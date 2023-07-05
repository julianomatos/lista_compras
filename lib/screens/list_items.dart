// ignore_for_file: prefer_const_constructors, use_build_context_synchronously

import 'package:current_converter/current_converter.dart';
import 'package:flutter/material.dart';
import 'package:lista_compras/routes/routes_path.dart';
import 'package:lista_compras/services/items_service.dart';
// import 'package:lista_compras/utils/current_converter.dart';
import '../components/cart_total.dart';
// import '../components/footer.dart';
import '../components/items_cart.dart';
import '../components/items_list.dart';
// import '../providers/item_provider.dart';
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
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de Compras'),
      ),
      body:
      //  Consumer<ItemsService>(
      //   builder: (context, itemsService, _) {
          // return 
          Column(
            children: const [
              Center(child: Text('Lista de itens pendentes.')),
              ItemsList(),
              // SizedBox(height: 10),
              // ItemsCart(),
            ],
          ),
      //   },
      // ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          // Abra a tela de criação de tarefa
          Navigator.of(context).pushNamed(RoutePaths.ITEM_ADD_SCREEN);
        },
      ),
      bottomNavigationBar: CartTotal(),
    );
  }
  // );
  // }
}
