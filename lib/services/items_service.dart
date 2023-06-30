// ignore_for_file: unused_import, unused_field

import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lista_compras/models/shopping_item.dart';
import 'package:lista_compras/repositories/items_repository.dart';

class ItemsService with ChangeNotifier {
  final ItemsRepository _itemsRepository = ItemsRepository();

  Future<List<ShoppingItem>> list() async {
    try {
      final List<ShoppingItem> list = [];
      final response = await _itemsRepository.list();
      final docs = response.docs;

      for (var doc in docs) {
        list.add(ShoppingItem.fromJson(doc.id, doc.data()));
      }
      

      return list;
    } catch (err) {
      print('Erro ao consultar lista: $err');
      throw Exception("Erro: Problemas ao consultar lista.");
    }
  }

  Future<String> insert(ShoppingItem item) async {
    try {
      final response = await _itemsRepository.insert(item.toJson());

      notifyListeners();

      return response.id;
    } catch (err) {
      throw Exception("Erro: Problemas ao inserir.");
    }
  }

  Future<ShoppingItem> show(String itemId) async {
    try {
      final response = await _itemsRepository.show(itemId);
      if (response.exists) {
        return ShoppingItem.fromJson(response.id, response.data()!);
      } else {
        throw Exception("Item não encontrado");
      }
    } catch (err) {
      throw Exception("Erro: Problemas ao exibir o item.");
    }
  }

  Future<void> update(String productId, ShoppingItem updatedItem) async {
    try {
      await _itemsRepository.update(productId, updatedItem.toJson());
    } catch (err) {
      throw Exception("Erro: Problemas ao atualizar o produto.");
    }
  }

  Future<void> delete(String productId) async {
    try {
      await _itemsRepository.delete(productId);
    } catch (err) {
      throw Exception("Erro: Problemas ao excluir o produto.");
    }
  }
}
