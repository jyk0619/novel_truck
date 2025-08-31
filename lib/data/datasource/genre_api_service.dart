import 'dart:convert';
import 'package:http/http.dart' as http;

class GenreApiService {
  final _baseUrl = 'https://dev.novel-truck.r-e.kr/v1';

  // 기록 목록 Get 요청
  Future<Map<String, dynamic>> getRecordList() async {
    final uri = Uri.parse('$_baseUrl/genres');
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      return jsonDecode(response.body) as Map<String, dynamic>;
    } else {
      throw Exception('Failed to fetch Record list: ${response.body}');
    }
  }


}
