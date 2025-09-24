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
      return jsonDecode(response.body);
    } else {
      print('서비스 - 에러탐지: ${response.statusCode}');
      throw Exception('Failed to post novel: ${response.statusCode}');
    }
  }

  //Get Novel List
  Future<Map<String, dynamic>> getNovelList() async {
    final uri = Uri.parse('$_baseUrl/novels?page=1&limit=100');
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      return jsonDecode(response.body) as Map<String, dynamic>;
    } else {
      throw Exception('Failed to fetch novel list: ${response.body}');
    }
  }

  //커스텀 테그 등록
  Future<Map<String, dynamic>> postTag(String tagName, int novelId) async {
    final uri = Uri.parse('$_baseUrl/novels/${novelId}/tags');
    final headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };
    final body = jsonEncode({'tagName': tagName});

    final response = await http.post(uri, headers: headers, body: body);

    if (response.statusCode == 200 || response.statusCode == 201) {
      return jsonDecode(response.body);
    } else {
      print('서비스 - 에러탐지: ${response.statusCode}');
      throw Exception('Failed to post novel: ${response.statusCode}');
    }
  }

  Future<Map<String, dynamic>> getGenreList() async {
    final uri = Uri.parse('$_baseUrl/genres');
    final response = await http.get(uri);

    if (response.statusCode == 200) {

      return jsonDecode(response.body) as Map<String, dynamic>;
    } else {
      throw Exception('Failed to fetch Record list: ${response.body}');
    }
  }

  Future<Map<String, dynamic>> getNovelDetail(id) async {
    final uri = Uri.parse('$_baseUrl/novels/${id}');
    final response = await http.get(uri);

    if (response.statusCode == 200) {

      return jsonDecode(response.body) as Map<String, dynamic>;
    } else {
      throw Exception('Failed to fetch Record list: ${response.body}');
    }
  }



}
