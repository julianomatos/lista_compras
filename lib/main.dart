
import 'package:flutter/material.dart';
import 'package:lista_compras/providers/item_provider.dart';
import 'package:lista_compras/screens/add_item.dart';
import 'package:lista_compras/screens/delete_item.dart';
import 'package:lista_compras/screens/edit_item.dart';
import 'package:lista_compras/screens/list_items.dart';
import 'package:provider/provider.dart';
import 'routes/routes_path.dart';

void main() {
  runApp(ChangeNotifierProvider(
      create: (context) => ItemProvider(),
      child: MyApp(),
    ));
}

// ignore: use_key_in_widget_constructors
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.blue)
            .copyWith(secondary: Colors.amber),
        //
      ),
      routes: {
        RoutePaths.HOME: (context) => const ListItems(),
        RoutePaths.ITEM_ADD_SCREEN: (context) => AddItem(),
        RoutePaths.ITEM_UPDATE_SCREEN: (context) => EditItem(),
        RoutePaths.ITEM_DELETE_SCREEN: (context) => DeleteItem(),
      }
    );
  }
}




