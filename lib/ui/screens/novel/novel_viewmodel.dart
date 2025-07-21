import 'package:flutter/foundation.dart';
import 'package:novel_truck/data/model/novel_model.dart';
import 'package:novel_truck/data/repository/novel_repository.dart';

class NovelViewModel extends ChangeNotifier {
  final NovelRepository _novelRepository = NovelRepository();

  final List<NovelData> _novelList = [];
  List<NovelData> get novelList => _novelList;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? errorMessage;

  NovelViewModel() {
    initialize();
  }

  Future<void> initialize() async {
    _isLoading = true;
    errorMessage = null;
    notifyListeners();

    try {
      await fetchNovelList();
    } catch (e) {
      errorMessage = '초기화 실패: $e';
    } finally {
      print('초기화 성공: 소설 목록을 불러왔습니다.');
      print('소설 목록 길이: ${_novelList.length}');
      _isLoading = false;
      notifyListeners();
    }
  }


  Future<void> fetchNovelList() async {
    _isLoading = true;
    errorMessage = null;
    notifyListeners();

    try {
      final novels = await _novelRepository.fetchNovelList(); // 반환 타입: NovelListResponseModel
      _novelList
        ..clear()
        ..addAll(novels);
    } catch (e) {
      errorMessage = '소설 목록을 불러오는 데 실패했습니다: $e';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void removeNovel(int index) {
    _novelList.removeAt(index);
    notifyListeners();
  }
}
