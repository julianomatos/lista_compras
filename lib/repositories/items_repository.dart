import 'package:cloud_firestore/cloud_firestore.dart';

class ItemsRepository {
  final db = FirebaseFirestore.instance;
 
  final String _collection; //collection
  ItemsRepository(this._collection);

 Future<QuerySnapshot<Map<String, dynamic>>> list() {
    return db.collection(_collection).get();
  }

  Future<DocumentReference<Map<String, dynamic>>> insert(
      Map<String, dynamic> data) {
    return db.collection(_collection).add(data);
  }

  Future<DocumentSnapshot<Map<String, dynamic>>> show(String id) {
    return db.collection(_collection).doc(id).get();
  }

  Future<void> update(String id, Map<String, dynamic> data) {
    return db.collection(_collection).doc(id).set(data);
  }

  Future<void> delete(String id) {
    return db.collection(_collection).doc(id).delete();
  }

  Future<double> calcularValorTotalProdutos() async {
    double valorTotal = 0.0;

    // Obtendo a coleção "produtos" do Firestore
    QuerySnapshot snapshot =
        await FirebaseFirestore.instance.collection('shopping_item').get();

    // Iterando sobre os documentos da coleção
    for (QueryDocumentSnapshot doc in snapshot.docs) {
      // Obtendo a quantidade e o preço de cada produto
      if (doc.exists) {
        int quantidade = (doc.data() as Map<String, dynamic>)['quantity'];
        double preco = (doc.data() as Map<String, dynamic>)['price'];

        // Calculando o valor total do produto
        double valorProduto = quantidade * preco;

        // Adicionando o valor do produto ao valor total
        valorTotal += valorProduto;
      }
    }

    return valorTotal;
  }
}
