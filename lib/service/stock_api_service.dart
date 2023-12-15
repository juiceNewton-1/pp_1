import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:stocks_tracker/models/stock.dart';

class StockApiService {
  Future<Stock> getStock(String symbol) async {
    try {
      final url = Uri.http('www.alphavantage.co', '/query', {
        'function': 'TIME_SERIES_INTRADAY',
        'symbol': symbol,
        'interval': '60min',
        'apikey': 'C63HWM73U7XVAFFF',
      });
      final response = await http.get(url);
      if (response.statusCode == 200) {
        return Stock.fromJson(json.decode(response.body));
      } else {
        throw Exception('Status code: ${response.statusCode}');
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<String> getAboutInformation(String symbol) async {
    try {
      final response = await http.get(
          Uri.parse(
              'https://real-time-finance-data.p.rapidapi.com/stock-overview?symbol=$symbol'),
          headers: {
            'X-RapidAPI-Key':
                '19672c07cbmsh0eb7ed69aa7a086p18194ajsn1e466426c7bc',
            'X-RapidAPI-Host': 'real-time-finance-data.p.rapidapi.com'
          });
      if (response.statusCode == 200) {
        return (jsonDecode(response.body) as Map<String, dynamic>)['data']
            ['about'];
      } else {
        throw Exception('Status code: ${response.statusCode}');
      }
    } catch (e) {
      rethrow;
    }
  }
}
