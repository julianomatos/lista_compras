import 'package:flutter_test/flutter_test.dart';
import 'package:lista_compras/models/shopping_item.dart';
import 'package:lista_compras/repositories/items_repository.dart';
import 'package:lista_compras/services/items_service.dart';
import 'package:mockito/mockito.dart';

class MockItemsRepository extends Mock implements ItemsRepository {}

void main() {
  late ItemsService itemsService;
  late ItemsRepository itemsRepository;
  late MockItemsRepository mockItemsRepository;

  setUp(() {
    mockItemsRepository = MockItemsRepository();
    itemsService = ItemsService();
    itemsRepository = mockItemsRepository;
  });

  group('ItemsService', () {
    final mockItem = ShoppingItem(
        id: '1',
        name: 'Item 1',
        isBought: false,
        observation: '',
        quantity: 0,
        unit: 'un');

    // test('list should return a list of ShoppingItems', () async {
    //   final mockResponse = [mockItem];

    //   when(mockItemsRepository.list()).thenAnswer((_) async => mockResponse);

    //   final result = await itemsService.list();

    //   expect(result, equals(mockResponse));
    // });

    // test('insert should return the inserted item id', () async {
    //   final mockResponse = '2';

    //   when(mockItemsRepository.insert(any!))
    //       .thenAnswer((_) async => mockResponse);

    //   final result = await itemsService.insert(mockItem);

    //   expect(result, equals(mockResponse));
    // });

    // test('show should return the specified ShoppingItem', () async {
    //   final mockResponse =  ShoppingItem(
    //     id: '1',
    //     name: 'Item 1',
    //     isBought: false,
    //     observation: '',
    //     quantity: 0,
    //     unit: 'un');

    //   when(mockItemsRepository.show(any)).thenAnswer((_) async => mockResponse);

    //   final result = await itemsService.show('1');

    //   expect(result, equals(mockResponse));
    // });

    test('update should update the specified ShoppingItem', () async {
      const mockProductId = '1';
      final updatedItem =  ShoppingItem(
        id: '1',
        name: 'Item 1',
        isBought: false,
        observation: '',
        quantity: 0,
        unit: 'un');
      await itemsService.update(mockProductId, updatedItem);

      verify(mockItemsRepository.update(mockProductId, updatedItem.toJson()))
          .called(1);
    });

    test('delete should delete the specified ShoppingItem', () async {
      const mockProductId = '1';

      await itemsService.delete(mockProductId);

      verify(mockItemsRepository.delete(mockProductId)).called(1);
    });
  });
}
