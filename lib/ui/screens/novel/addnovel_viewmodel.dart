import 'package:flutter/material.dart';
import 'package:novel_truck/data/model/novel_model.dart';
import 'package:novel_truck/data/repository/novel_repository.dart';


class AddNovelViewModel extends ChangeNotifier {
  final NovelRepository _repository = NovelRepository();

  TextEditingController novelUrlController = TextEditingController();

  bool isLoading = false;
  String? errorMessage;
  NovelData? novel; // 소설 데이터


  // 소설 등록
  Future<void> submitNovelUrl(String url) async {
    errorMessage=null;
    _setLoading(true);

    try {
      final response = await _repository.submitNovel(url); // API 호출 → ID 받음
      novel = NovelData.fromResponse(response);
      print('소설 등록 성공: ${novel?.imgPath}'); // 디버깅용 로그
      notifyListeners(); // 소설 데이터 업데이트
    } catch (e) {
      errorMessage = '소설 등록 실패 : $e';
    } finally {
      _setLoading(false);
    }
  }

  // 상태 초기화
  void reset() {
    novelUrlController.clear();
    novel = null;
    errorMessage = null;
    notifyListeners();
  }

  // 로딩 상태 변경
  void _setLoading(bool value) {
    isLoading = value;
    notifyListeners();
  }
  
  @override
  void dispose() {
    novelUrlController.dispose();
    super.dispose();
  }
  // Additional methods for saving the novel, validation, etc. can be added here.
}