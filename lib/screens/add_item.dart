// ignore_for_file: avoid_types_as_parameter_names, must_be_immutable, use_key_in_widget_constructors, null_check_always_fails

import 'package:flutter/material.dart';
import 'package:lista_compras/providers/item_provider.dart';
import 'package:lista_compras/utils/data_utils.dart';
import '../components/footer.dart';
import '../models/shopping_item.dart';
import 'package:provider/provider.dart';

class AddItem extends StatelessWidget {
  final _name = TextEditingController();
  final _quantity = TextEditingController();
  final _date = TextEditingController();
  final _price = TextEditingController();
  String _selectedUnit = '';
  DateTime selectedDateTime = DateTime(2023, 1, 1, 0, 0, 0);
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
                        hintText: 'Descrição do item',
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16.0),
                Row(
                  children: [
                    Expanded(
                      child: Card(
                        elevation: 8,
                        child: ListTile(
                          title: TextField(
                            controller: _quantity,
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                              labelText: "Quantidade",
                              hintText: '0.00',
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Card(
                        elevation: 8,
                        child: ListTile(
                          title: DropdownButtonFormField<String>(
                            items: DataUtils.unitTypes.map((String unit) {
                              return DropdownMenuItem<String>(
                                value: unit,
                                child: Text(unit),
                              );
                            }).toList(),
                            value: 'un',
                            decoration: const InputDecoration(
                              labelText: "Unidade",
                            ),
                            onChanged: (value) {
                              _selectedUnit = value!;
                            },
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Container(
                    margin: const EdgeInsets.only(top: 36, bottom: 12),
                    child: const Text(
                      'Dados da última compra:',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    )),
                Row(
                  children: [
                    Expanded(
                      child: Card(
                        elevation: 8,
                        child: ListTile(
                          title: TextField(
                            controller: _price,
                            decoration: const InputDecoration(
                              labelText: "Preço",
                              hintText: 'Último preço pago',
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Card(
                        elevation: 8,
                        child: ListTile(
                          title: TextField(
                            enabled: false,
                            controller: _date,
                            decoration: const InputDecoration(
                              labelText: 'Data',
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
                              if (selectedDate != null &&
                                  selectedTime != null) {
                                selectedDateTime = DateTime(
                                  selectedDate.year,
                                  selectedDate.month,
                                  selectedDate.day,
                                  selectedTime.hour,
                                  selectedTime.minute,
                                );
                                _date.text =
                                    DataUtils.formatDate(selectedDateTime);
                              }
                            },
                          ),
                        ),
                      ),
                    ),
                  ],
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
                  price: double.parse(_price.text),
                  observation: '',
                  unit: _selectedUnit,
                  quantity: int.parse(_quantity.text),
                  purchaseDate: selectedDateTime,
                  // purchaseLocation: '',
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
