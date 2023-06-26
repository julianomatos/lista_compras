// ignore_for_file: avoid_types_as_parameter_names, must_be_immutable, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:lista_compras/providers/item_provider.dart';
import 'package:lista_compras/utils/data_utils.dart';
import '../components/footer.dart';
import '../models/shopping_item.dart';
import 'package:provider/provider.dart';

class AddItem extends StatelessWidget {
  final _name = TextEditingController();
  final _quantity = TextEditingController();
  final _brand = TextEditingController();
  final _price = TextEditingController();
  String _selectedUnit = '';

  @override
  Widget build(BuildContext context) {
    return Consumer<ItemProvider>(
      builder: (context, itemProvider, _) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Incluir item'),
          ),
          body: Form(
            child: Column(
              children: [
                Card(
                  elevation: 8,
                  child: ListTile(
                    title: TextField(
                      style: const TextStyle(fontSize: 18),
                      controller: _name,
                      decoration: const InputDecoration(
                        labelText: 'Nome do Item',
                      ),
                    ),
                  ),
                ),
                Card(
                  elevation: 8,
                  child: ListTile(
                    title: TextField(
                      controller: _quantity,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: "Quantidade",
                      ),
                    ),
                  ),
                ),
                Card(
                  elevation: 8,
                  child: ListTile(
                    title: DropdownButtonFormField<String>(
                      items: DataUtils.unitTypes.map((String unit) {
                        return DropdownMenuItem<String>(
                          value: unit,
                          child: Text(unit),
                        );
                      }).toList(),
                      // value: _selectedUnit,
                      decoration: const InputDecoration(
                        labelText: "Unidade",
                      ),
                      onChanged: (value) {
                        _selectedUnit = value!;
                      },
                    ),
                  ),
                ),
                 Card(
                  elevation: 8,
                  child: ListTile(
                    title: TextField(
                      controller: _price,
                      decoration: const InputDecoration(
                        labelText: "Preço",
                      ),
                    ),
                  ),
                ),
                Card(
                  elevation: 8,
                  child: ListTile(
                    title: TextField(
                      controller: _brand,
                      decoration: const InputDecoration(
                        labelText: "Marca",
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        
          floatingActionButton: FloatingActionButton(
            child: const Icon(Icons.save),
            onPressed: () {
              if (_name.text.isNotEmpty) {
                final item = ShoppingItem(
                  name: _name.text,
                  price: 0,
                  brand: '',
                  unit: _selectedUnit,
                  quantity: int.parse(_quantity.text),
                  purchaseDate: DateTime.now(),
                  purchaseLocation: '',
                  isBought: false,
                );

                itemProvider.addItem(item);
                Navigator.pop(context);
              } else {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text('Erro'),
                    content: const Text('Por favor, preencha todos os campos.'),
                    actions: [
                      TextButton(
                        child: const Text('OK'),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ],
                  ),
                );
              }
            },
          ),
          bottomNavigationBar: const Footer(),
        );
      },
    );
  }
}
