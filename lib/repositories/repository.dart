import 'package:http/http.dart' as http;

abstract class Repository {
  final _baseUrl = "https://dmcflutter23-default-rtdb.firebaseio.com/";

  final String _collection; //collection
  Repository(this._collection);

 Future<http.Response>  listApi(){
    return http.get(Uri.parse('$_baseUrl/$_collection.json'));
 }
}
