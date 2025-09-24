import 'package:flutter/material.dart';
import '../../../data/model/record_model.dart';
import '../../../data/repository/record_repository.dart';

class NovelDetailViewModel extends ChangeNotifier {
  final RecordRepository _recordRepository = RecordRepository();

  List<RecordData> _recordData = [];
  List<RecordData> get recordData => _recordData;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? errorMessage;

  Future<void> initialize(novelId) async {
    _isLoading = true;
    errorMessage = null;
    notifyListeners();

    try {
      await fetchRecordList(novelId);
    } catch (e) {
      errorMessage = '초기화 실패: $e';
      print('초기화 실패: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> fetchRecordList(novelId) async {
    _recordData.clear();

    try {
      final record = await _recordRepository.fetchRecordList();
      final allRecords = record.items.map((item) => RecordData.fromResponse(item)).toList();
      _recordData = allRecords.where((item) => item.novelId == novelId).toList();
    } catch (e) {
      errorMessage = '기록을 불러오는 데 실패했습니다.';
      print('기록 목록을 불러오는 데 실패했습니다: $e');
      rethrow; // initialize에서 에러 처리를 위해
    }
  }

  Future<void> toggleBookmark(recordId) async {
    try {
      // RecordRepository로 북마크 상태 변경
      await _recordRepository.fetchBookMark(recordId);

      // 로컬 데이터 업데이트
      final index = _recordData.indexWhere((record) => record.id == recordId);
      if (index != -1) {
        _recordData[index].isBookmarked = !_recordData[index].isBookmarked;
        notifyListeners();
      }
    } catch (e) {
      print('북마크 업데이트 실패: $e');
    }
  }

  // 데이터 새로고침용 메서드 추가
  Future<void> refresh(novelId) async {
    await initialize(novelId);
  }

  @override
  void dispose() {
    _recordData.clear();
    super.dispose();
  }
}
