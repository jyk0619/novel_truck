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
      _isLoading = false;
      notifyListeners();
    }
  }


  Future<void> fetchNovelList() async {
    _isLoading = true;
    errorMessage = null;
    var novels = NovelListResponseModel(items: [], total: 0, totalPages: 0, hasNext: false);
    notifyListeners();

    try {
      novels = await _novelRepository.fetchNovelList(); // 반환 타입: NovelListResponseModel
      print('소설 목록을 성공적으로 불러왔습니다: ${novels.items.length}개의 소설이 있습니다.');
    } catch (e) {
      errorMessage = '소설 목록을 불러오는 데 실패했습니다: $e';
    } finally {
      //noveldata에 소설 목록 저장
      _novelList.clear();
      _novelList.addAll(novels.items.map((item) => NovelData(
        item.title,
        item.author,
        item.imgpath,
        item.id,
        item.genreId,
        item.genreName,
        item.tags,
      )).toList());
      print('소설 목록 불러오기 완료');
      _isLoading = false;
      notifyListeners();
    }
  }

  void removeNovel(int index) {
    _novelList.removeAt(index);
    notifyListeners();
  }
}
