import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:novel_truck/data/model/novel_model.dart';
import 'package:novel_truck/data/repository/novel_repository.dart';

class NovelViewModel extends ChangeNotifier {
  final NovelRepository _novelRepository = NovelRepository();

  final List<NovelData> _novelList = [];
  List<NovelData> get novelList => _novelList;

  List<NovelData> _searchResults = [];

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
        item.description,
        item.tags,
      )).toList());
      _isLoading = false;
      notifyListeners();
    }
  }

  final TextEditingController searchController = TextEditingController();

  List<NovelData> get searchData =>
      _searchResults.isEmpty ? _novelList : _searchResults;



  void searchNovel(String query) {
    _searchResults.clear();

    if (query.isEmpty) {
      // 검색어가 없을 경우, 결과는 비워둔다 → getter에서 _novelList 반환됨
      notifyListeners();
      return;
    }

    // 검색어가 있을 경우: 필터링 후 결과 저장
    _searchResults.addAll(
      _novelList.where((novel) {
        final titleMatch = novel.title.toLowerCase().contains(query.toLowerCase());
        final authorMatch = novel.author.toLowerCase().contains(query.toLowerCase());
        notifyListeners();
        return titleMatch || authorMatch;
      }),
    );

    notifyListeners();
  }


  void clearSearch() {
    searchController.clear();
    print('검색어 초기화');
    notifyListeners();
  }

  void removeNovel(int index) {
    _novelList.removeAt(index);
    notifyListeners();
  }
}
