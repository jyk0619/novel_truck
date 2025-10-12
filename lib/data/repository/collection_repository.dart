
import 'dart:io';

import '../datasource/collection_api_service.dart';
import '../model/collection_model.dart';

class CollectionRepository {
  final _apiService = CollectionApiService();

  // 1. Presigned URL 받아서 이미지 업로드 후 컬렉션 등록
  Future<void> addCollection({
    required String title,
    required File imageFile,
  }) async {
    try {
      // 1️⃣ presigned URL 발급
      final presignedUrl = await _apiService.postPresignedUrl();

      // 2️⃣ presigned URL로 실제 이미지 업로드
      await _apiService.uploadImage(imageFile, presignedUrl);

      // presigned URL에는 실제 업로드된 S3 URL 정보가 포함돼 있을 수도 있지만,
      // 백엔드에서 imageUrl을 별도로 응답하지 않으면, presignedUrl에서 base URL만 잘라낼 필요가 있음.
      // 예시로, presignedUrl.split('?')[0] 하면 실제 파일 접근 URL만 남음.
      final imgUrl = presignedUrl.split('?').first;
      // 3️⃣ 컬렉션 등록
      await _apiService.postCollection(title, imgUrl);
    } catch (e) {
      throw Exception('컬렉션 생성 중 오류 발생: $e');
    }
  }

  Future<CollectionListResponse> fetchCollectionList() async {
    final jsonList = await _apiService.getCollectionList();
    return CollectionListResponse.fromJson(jsonList);
  }


}
