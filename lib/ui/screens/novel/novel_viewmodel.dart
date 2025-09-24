import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:novel_truck/data/model/novel_model.dart';
import 'package:novel_truck/data/repository/novel_repository.dart';
import 'package:novel_truck/data/model/genre_model.dart';

class NovelViewModel extends ChangeNotifier {
  final NovelRepository _novelRepository = NovelRepository();

  final List<NovelData> _novelList = [];
  List<NovelData> get novelList => List.unmodifiable(_novelList);

  // 검색과 필터를 위한 상태 변수들
  String _searchQuery = '';
  Set<String> _selectedGenreIds = {};

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
      await fetchGenreList();
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
      novels = await _novelRepository.fetchNovelList();
    } catch (e) {
      errorMessage = '소설 목록을 불러오는 데 실패했습니다: $e';
    } finally {
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

  final TextEditingController novelSearchController = TextEditingController();

  // 통합 필터링 로직 - 검색어와 장르 필터를 모두 적용
  List<NovelData> get searchData {
    List<NovelData> filtered = _novelList;

    // 1. 검색어 필터링
    if (_searchQuery.isNotEmpty) {
      filtered = filtered.where((novel) {
        final titleMatch = novel.title.toLowerCase().contains(_searchQuery.toLowerCase());
        final authorMatch = novel.author.toLowerCase().contains(_searchQuery.toLowerCase());
        return titleMatch || authorMatch;
      }).toList();
    }

    // 2. 장르 필터링
    if (_selectedGenreIds.isNotEmpty) {
      filtered = filtered.where((novel) {
        return _selectedGenreIds.contains(novel.genreId);
      }).toList();
    }

    return filtered;
  }

  void searchNovel(String query) {
    _searchQuery = query;
    notifyListeners();
  }

  void filterByGenres(Set<String> genreIds) {
    _selectedGenreIds = genreIds;
    notifyListeners();
  }

  // 검색어와 필터 초기화
  void clearSearch() {
    novelSearchController.clear();
    _searchQuery = '';
    notifyListeners();
  }

  void clearAllFilters() {
    novelSearchController.clear();
    _searchQuery = '';
    _selectedGenreIds.clear();
    notifyListeners();
  }

  final TextEditingController tagController = TextEditingController();

  Future<void> addTag(tagName, novelId) async {
    await _novelRepository.postTag(tagName, novelId);
    print('태그 추가');
    // 태그 추가 후 데이터 새로고침이 필요한 경우
    // await fetchNovelList();
  }

  void removeNovel(int index) {
    if (index >= 0 && index < _novelList.length) {
      _novelList.removeAt(index);
      notifyListeners();
    }
  }

  final List<GenreData> _genreList = [];
  List<GenreData> get genreList => List.unmodifiable(_genreList);

  Future<void> fetchGenreList() async {
    _genreList.clear();

    try {
      final genres = await _novelRepository.fetchGenreList();
      _genreList.addAll(genres.data.map((item) => GenreData.fromResponse(item)).toList());
    } catch (e) {
      errorMessage = '장르 목록을 불러오는 데 실패했습니다: $e';
    } finally {
      notifyListeners();
    }
  }

  // 현재 선택된 장르 ID들을 반환
  Set<String> get selectedGenreIds => Set.from(_selectedGenreIds);

  // 현재 검색어를 반환
  String get currentSearchQuery => _searchQuery;
}