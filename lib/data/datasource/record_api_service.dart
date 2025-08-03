import 'dart:convert';
import 'package:http/http.dart' as http;

class RecordApiService {
  final _baseUrl = 'https://dev.novel-truck.r-e.kr/v1';

  /// 기록 Post 요청
  Future<Map<String, dynamic>> postRecord(String novelId,String content) async {
    final uri = Uri.parse('$_baseUrl/notes');
    final headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };
    final body = jsonEncode({'content': content});

    final response = await http.post(uri, headers: headers, body: body);

    if (response.statusCode == 200 || response.statusCode == 201) {

      print('Response: ${response.body}');
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to post record: ${response.body}');
    }
  }

  // 기록 목록 Get 요청
  Future<Map<String, dynamic>> getRecordList() async {
    final uri = Uri.parse('$_baseUrl/notes');
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      return jsonDecode(response.body) as Map<String, dynamic>;
    } else {
      throw Exception('Failed to fetch Record list: ${response.body}');
    }
  }
}
