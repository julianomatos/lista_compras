// ignore_for_file: unused_import, unused_field

import 'dart:convert';
// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lista_compras/models/shopping_item.dart';
import 'package:lista_compras/repositories/item_repository.dart';
// import 'package:http/http.dart';

class ProductsService {
  final ItemsRepository _itemsRepository = ItemsRepository();

  Future<List<ShoppingItem>> list() async {
    try {
      final List<ShoppingItem> list = [];
      // final response = await _itemsRepository.list();
      // final docs = response.docs;
      // for (var doc in docs) {
      //   list.add(ShoppingItem.fromJson(doc.id, doc.data()));
      // }
      return list;
      // if (response.statusCode == 200) {
      // Map<String, dynamic> json = jsonDecode(response.body);
      // return Product.listFromJson(json);
      // } else {
      // throw Exception('Erro ${response.statusCode}: Problemas ao consultar lista.');
      // }
    } catch (err) {
      throw Exception("Erro: Problemas ao consultar lista.");
    }
  }

  // Future<String> insert(ShoppingItem item) async {
  //   try {
      // String json = jsonEncode(product.toJson());
      // final response = await _itemsRepository.add(item.toJson());
      // return response.id;
      // if (response.statusCode == 201) {
      //   return jsonDecode(response.body) as String;
      // } else {
      //   throw Exception('Erro ${response.statusCode}: Problemas ao inserir.');
  //     // }
  //   } catch (err) {
  //     throw Exception("Erro: Problemas ao inserir.");
  //   }
  // }

  // Future<Product> show(String productId) async {
  //   try {
  //     final response = await _productsRepository.show(productId);

  //     // if (response.statusCode == 200) {
  //       // Map<String, dynamic> json = jsonDecode(response.body);
  //       // return response.data(productId);
  //     // } else {
  //       // throw Exception(
  //       //     'Erro ${response.statusCode}: Problemas ao exibir o produto.');
  //     // }
  //   } catch (err) {
  //     throw Exception("Erro: Problemas ao exibir o produto.");
  //   }
  // }

  // Future<void> update(String productId, Product updatedProduct) async {
  //   try {
  //     String json = jsonEncode(updatedProduct.toJson());
  //     Response response = await _productsRepository.update(productId, json);

  //     if (response.statusCode != 200) {
  //       throw Exception(
  //           'Erro ${response.statusCode}: Problemas ao atualizar o produto.');
  //     }
  //   } catch (err) {
  //     throw Exception("Erro: Problemas ao atualizar o produto.");
  //   }
  // }

  // Future<void> delete(String productId) async {
  //   try {
  //     Response response = await _productsRepository.delete(productId);

  //     if (response.statusCode != 200) {
  //       throw Exception(
  //           'Erro ${response.statusCode}: Problemas ao excluir o produto.');
  //     }
  //   } catch (err) {
  //     throw Exception("Erro: Problemas ao excluir o produto.");
  //   }
  // }
}
