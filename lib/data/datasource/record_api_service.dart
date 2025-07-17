import 'dart:convert';
import 'package:http/http.dart' as http;

class RecordApiService {
  final _baseUrl = 'https://dev.novel-truck.r-e.kr/v1';

  Future<Map<String, dynamic>> postRecord(String novelId,String content) async {
    final uri = Uri.parse('$_baseUrl/${novelId}/Notes');
    final headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };
    final body = jsonEncode({'content': content});

    final response = await http.post(uri, headers: headers, body: body);

    if (response.statusCode == 200 || response.statusCode == 201) {

      print('Novel Id: $novelId');
      print('Response: ${response.body}');
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to post record: ${response.body}');
    }
  }
}
