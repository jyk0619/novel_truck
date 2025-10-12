import 'dart:io';
import 'dart:convert';
import 'package:http/http.dart' as http;

class CollectionApiService {
  final _baseUrl = 'https://dev.novel-truck.r-e.kr/v1';

  // 1. Presigned URL 요청
  Future<String> postPresignedUrl() async {
    final uri = Uri.parse('$_baseUrl/upload/presigned-url');
    final headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };
    final body = jsonEncode({
      'type': "PLAYLIST_THUMBNAIL",
      'contentType': "image/jpeg",
      'fileExtension': ".jpg"
    });

    final response = await http.post(uri, headers: headers, body: body);

    if (response.statusCode == 200 || response.statusCode == 201) {
      final data = jsonDecode(response.body);
      return data['data']['signedUrl']; // presigned URL 반환
    } else {
      throw Exception('Presigned URL 요청 실패: ${response.statusCode}');
    }
  }

  // 2. 실제 이미지 업로드
  Future<void> uploadImage(File imageFile, String presignedUrl) async {
    final bytes = await imageFile.readAsBytes();
    final response = await http.put(
      Uri.parse(presignedUrl),
      headers: {'Content-Type': 'image/jpeg'},
      body: bytes,
    );

    if (response.statusCode != 200 && response.statusCode != 201) {
      throw Exception('이미지 업로드 실패');
    }
  }

  // 3. 컬렉션 등록
  Future<void> postCollection(String title, String imgUrl) async {
    final uri = Uri.parse('$_baseUrl/playlists');
    final headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };
    final body = jsonEncode({
      'title': title,
      'description': 'string',
      'thumbnail': imgUrl,
      'isPublic': false,
    });

    final response = await http.post(uri, headers: headers, body: body);

    print('컬렉션 등록 응답: ${response.body}');
    if (response.statusCode != 200 && response.statusCode != 201) {
      throw Exception('컬렉션 등록 실패: ${response.statusCode}');
    }
  }

  // 컬렉션 리스트 조회
  Future<Map<String, dynamic>> getCollectionList() async {
    final uri = Uri.parse('$_baseUrl/playlists');
    final headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };

    final response = await http.get(uri, headers: headers);

    if (response.statusCode == 200) {
      print('컬렉션 리스트 조회 응답: ${response.body}');
      return jsonDecode(response.body);
    } else {
      throw Exception('컬렉션 리스트 조회 실패: ${response.statusCode}');
    }
  }
}
