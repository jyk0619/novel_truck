import 'dart:convert';
import 'package:http/http.dart' as http;

class RecordApiService {
  final _baseUrl = 'https://dev.novel-truck.r-e.kr/v1';

  /// 기록 Post 요청
  Future<Map<String, dynamic>> postRecord(int novelId,String content) async {
    final uri = Uri.parse('$_baseUrl/notes');
    final headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };
    final body = jsonEncode(
        {
          'novelId': novelId, // 실제 novelId를 넣어야 합니다.
          'content': content
        });

    final response = await http.post(uri, headers: headers, body: body);

    if (response.statusCode == 200 || response.statusCode == 201) {

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
      print('서비스 - 에러탐지: ${response.statusCode}');
      throw Exception('Failed to fetch Record list: ${response.body}');
    }
  }

  // 기록 북마크 목록 Get 요청
  Future<Map<String, dynamic>> getBookMarkList() async {
    final uri = Uri.parse('$_baseUrl/notes/bookmarks');
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      return jsonDecode(response.body) as Map<String, dynamic>;
    } else {
      throw Exception('Failed to fetch BookMark list: ${response.body}');
    }
  }

  // 기록 북마크 설정
  Future<Map<String, dynamic>> postBookMark(int id) async {
    final uri = Uri.parse('$_baseUrl/notes/${id}/bookmark');

    final headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };
    final body = jsonEncode(
        {
          'novelId': id, // 실제 novelId를 넣어야 합니다.
        });

    final response = await http.post(uri, headers: headers, body: body);

    if (response.statusCode == 200|| response.statusCode == 201) {
      return jsonDecode(response.body) as Map<String, dynamic>;
    } else {
      throw Exception('(service)Failed to fetch BookMark: ${response.body}');
    }
  }

}
