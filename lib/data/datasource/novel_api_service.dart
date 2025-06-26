import 'dart:convert';
import 'package:http/http.dart' as http;

class NovelApiService {
  final _baseUrl = 'https://dev.novel-truck.r-e.kr/v1';

  Future<Map<String, dynamic>> postNovelUrl(String novelUrl) async {
    final uri = Uri.parse('$_baseUrl/novels');
    final headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };
    final body = jsonEncode({'url': novelUrl});

    final response = await http.post(uri, headers: headers, body: body);

    if (response.statusCode == 200 || response.statusCode == 201) {

      print('Novel URL: $novelUrl');
      print('Response: ${response.body}');
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to post novel: ${response.body}');
    }
  }
}
