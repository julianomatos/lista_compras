import 'dart:convert';
import 'package:http/http.dart' as http;

// Tabela top 10 moedas - País de origem

// 1	Dólar americano	(USD)	Estados Unidos
// 2	Euro	(EUR)	Países da Zona do Euro
// 3	Iene	(JPY)	Japão
// 4	Libra Esterlina	(GBP)	Reino Unido
// 5	Franco Suíço	(CHF)	Suíça
// 6	Dólar Canadense 	(CAD)	Canadá
// 7	Dólar Australiano	(AUD/NZD)	Austrália
// 8	Rand	(ZAR)	África do Sul
// 9	Yuan	(CNY)	China
// 10	Peso Argentino 	(ARS)	Argentina
class CurrentConverter {
  Future<double> getExchangeRate(String moeda) async {
    var response = await http
        .get(Uri.parse('https://api.exchangerate-api.com/v4/latest/BRL'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final exchangeRate = data['rates'][moeda]; // Obtém a taxa de câmbio

      return exchangeRate;
    } else {
      return 0;
    }
  }

  Future<double> convertDollar(valor) async {
    final exchangeRate = await getExchangeRate('USD');
    final valorDollar = valor * exchangeRate;
    return valorDollar;
  }

  Future<double> convertEuro(valor) async {
    final exchangeRate = await getExchangeRate('EUR');
    final valorEuro = valor * exchangeRate;
    return valorEuro;
  }

  Future<double> convertYen(valor) async {
    final exchangeRate = await getExchangeRate('JPY');
    final valorYen = valor * exchangeRate;
    return valorYen;
  }

  Future<double> convertPound(valor) async {
    final exchangeRate = await getExchangeRate('GPB');
    final valorPound = valor * exchangeRate;
    return valorPound;
  }

  Future<double> convertArgentinePeso(valor) async {
    final exchangeRate = await getExchangeRate('ARS');
    final valorPeso = valor * exchangeRate;
    return valorPeso;
  }

  // static Future<double> convertDolar(valor) async {
  //   // Faz a requisição à API para obter as taxas de câmbio atualizadas
  //   var response = await http
  //       .get(Uri.parse('https://api.exchangerate-api.com/v4/latest/BRL'));

  //   if (response.statusCode == 200) {
  //     final data = json.decode(response.body);
  //     final exchangeRate =
  //         data['rates']['USD']; // Obtém a taxa de câmbio de BRL para USD

  //     final valorDollar = valor * exchangeRate;

  //     return valorDollar;
  //   } else {
  //     return 0;
  //   }
  // }
}
