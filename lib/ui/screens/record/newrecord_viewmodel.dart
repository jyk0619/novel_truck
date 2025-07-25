

import 'package:flutter/material.dart';

class NewRecordViewModel extends ChangeNotifier {



  // 초기화 메소드
  NewRecordViewModel() {
    initialize();
  }

  Future<void> initialize() async {
    // 초기화 로직이 필요하다면 여기에 작성
    notifyListeners();
  }

  void selectedNovel() {

  }

  // 여기에 필요한 메소드와 속성을 추가하세요.
  // 예: 소설 선택, 기록 저장 등
}