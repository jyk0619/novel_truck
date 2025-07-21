import 'package:flutter/material.dart';
import 'package:novel_truck/data/model/novel_model.dart';
import 'package:novel_truck/data/repository/novel_repository.dart';


class AddNovelViewModel extends ChangeNotifier {
  final NovelRepository _repository = NovelRepository();

  TextEditingController novelUrlController = TextEditingController();

  bool isLoading = false;
  String? errorMessage;
  String? novelId;
  String? novelTitle;
  String? novelImage;
  String? novelGenreId;
  String? novelGenreName;

  // 소설 등록
  Future<void> submitNovelUrl(String url) async {
    isLoading = true;
    errorMessage = null;
    notifyListeners();

    try {
      final response = await _repository.submitNovel(url); // API 호출 → ID 받음

      // 💡 예시로 더미 제목과 작가명, 이미지 경로를 사용
      final newNovel = NovelData(
        '새 소설 제목',
        '작가 미정',
        'assets/images/default.jpg',
        response.id,
        response.genreId,
        response.genreName,
      );

      novelId = response.id; // 소설 ID 저장
      novelTitle = response.title;
      novelImage = response.imgpath;
      novelGenreId = response.genreId;
      novelGenreName = response.genreName;

    } catch (e) {
      errorMessage = '소설 등록 실패: $e';
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  // Additional methods for saving the novel, validation, etc. can be added here.
}