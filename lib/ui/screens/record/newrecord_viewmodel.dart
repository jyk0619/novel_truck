

import 'package:flutter/material.dart';

import '../../../data/model/novel_model.dart';
import '../../../data/repository/record_repository.dart';

class NewRecordViewModel extends ChangeNotifier {

  final _recordRepository = RecordRepository(); // RecordRepository 인스턴스 생성
  final TextEditingController contentController = TextEditingController(); // 기록 내용을 입력할 컨트롤러
  // 선택된 소설 ID (필요시 사용)
  int? selectedNovelId;
  NovelData? selectedNovel; // 선택된 소설 데이터 (필요시 사용)



  Future<void> initialize() async {
    // 초기화 로직이 필요하다면 여기에 작성
    notifyListeners();
  }

  Future<void> postRecord(int novelId,String content) async {
    // 여기에 기록 저장 로직을 추가하세요.
    try{
      print('아이디 : $novelId');
      print('내용 : $content');
      final response= await _recordRepository.submitRecord(novelId, content);
      print('기록 저장 성공: ${response.id}'); // 디버깅용 로그
    }catch(e){
      print('기록 저장 실패: $e');
    }
    // 저장 후 UI 갱신
    notifyListeners();
  }

  void selectNovel(NovelData novel) {
    // 소설 선택 로직을 여기에 작성하세요.
    // 예: selectedNovelId = 선택된 소설의 ID;
    selectedNovel= novel;
    print('선택된 소설: ${novel.id}'); // 디버깅용 로그

    notifyListeners();
  }

  // 여기에 필요한 메소드와 속성을 추가하세요.
  // 예: 소설 선택, 기록 저장 등
}