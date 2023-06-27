// ignore_for_file: use_key_in_widget_constructors, must_be_immutable

import 'package:flutter/material.dart';
import 'package:lista_compras/models/shopping_item.dart';
import 'package:provider/provider.dart';
import '../components/footer.dart';
import '../providers/item_provider.dart';
import '../utils/data_utils.dart';

class EditItem extends StatelessWidget {
  DateTime? selectedDateTime;
  final _date = TextEditingController();
  final _name = TextEditingController();
  final _unity= TextEditingController();
  final _quantity = TextEditingController();
  final _location = TextEditingController();

  @override
  Widget build(BuildContext context) {
    int index = ModalRoute.of(context)!.settings.arguments as int;

    return Consumer<ItemProvider>(builder: (context, itemProvider, _) {
      ShoppingItem item = itemProvider.showItem(index);
      _name.text = item.name;
      _date.text = DataUtils.formatDate(item.purchaseDate!);
      selectedDateTime = item.purchaseDate;
      _location.text = item.purchaseLocation!;
      return Scaffold(
        appBar: AppBar(
          title: const Text('Editar Item'),
        ),
        body:
            Column(
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
            const SizedBox(height: 16.0),
            Card(
              elevation: 8,
              child: ListTile(
                title: TextField(
                  enabled: false,
                  controller: _date,
                  decoration: const InputDecoration(
                    labelText: 'Data da Compra',
                  ),
                ),
                trailing: IconButton(
                  icon: const Icon(Icons.edit_calendar),
                  iconSize: 32,
                  color: Colors.black87,
                  onPressed: () async {
                    final selectedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2021),
                        lastDate: DateTime(2024),
                      );
                      // ignore: use_build_context_synchronously
                      final selectedTime = await showTimePicker(
                          context: context,
                          initialTime: TimeOfDay.now());
                      if (selectedDate != null && selectedTime != null) {
                        selectedDateTime = DateTime(
                            selectedDate.year,
                            selectedDate.month,
                            selectedDate.day,
                            selectedTime.hour,
                            selectedTime.minute,
                          );
                        _date.text = DataUtils.formatDate(selectedDateTime!);
                      }
                  },
                ),
              ),
            ),
            const SizedBox(height: 16.0),
            Card(
              elevation: 8,
              child: ListTile(
                title: TextField(
                  enabled: false,
                  controller: _location,
                  decoration: const InputDecoration(
                    labelText: "Localização",
                  ),
                ),
                trailing: IconButton(
                  iconSize: 32,
                  color: Colors.black87,
                  icon: const Icon(Icons.location_on),
                  onPressed: () async {
                    final currentPosition = await DataUtils.getLocation();
                    _location.text = currentPosition;
                  },
                ),
              ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(


          child: const Icon(Icons.save),
          onPressed: () {
            if (_name.text.isNotEmpty && _location.text.isNotEmpty) {
              final updatedItem = ShoppingItem(
                  name: _name.text,
                  price: 0,
                  brand: '',
                  unit: _unity.text,
                  quantity:  int.parse(_quantity.text) ,
                  purchaseDate: DateTime.now(),
                  purchaseLocation: '',
                  isBought: false,
                );

              itemProvider.editItem(index, updatedItem);
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
    });
  }
}
