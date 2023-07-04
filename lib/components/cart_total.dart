// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:current_converter/current_converter.dart';
import '../repositories/items_repository.dart';

class CartTotal extends StatelessWidget {
  final ItemsRepository _itemsRepository = ItemsRepository();
  final CurrentConverter _currentConverter = CurrentConverter();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<double>(
      future: _itemsRepository.cartTotal(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Erro ao calcular o valor total dos produtos');
        } else if (snapshot.hasData) {
          double total = snapshot.data!;
          return FutureBuilder<double>(
            future: _currentConverter.convertDollar(total),
            builder: (context, dollarSnapshot) {
              if (dollarSnapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              } else if (dollarSnapshot.hasError) {
                return Text('Erro ao converter o valor para dólar');
              } else if (dollarSnapshot.hasData) {
                double dollar = dollarSnapshot.data!;
                return Container(
                  height: 40,
                  color: Colors.blue,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Total Carrinho: R\$ ${total.toStringAsFixed(2)} -> U\$ ${dollar.toStringAsFixed(2)}',
                      style: TextStyle(
                        fontSize: 18,
                        // fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                );
              } else {
                return Text('Nenhum produto comprado');
              }
            },
          );
        } else {
          return Text('Nenhum produto comprado');
        }
      },
    );
  }
}
