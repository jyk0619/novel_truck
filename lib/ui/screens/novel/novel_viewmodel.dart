

import 'package:flutter/foundation.dart';
import 'package:novel_truck/data/model/novel_model.dart';
import 'package:novel_truck/data/repository/novel_repository.dart';

class NovelViewModel extends ChangeNotifier {
  final NovelRepository _repository = NovelRepository();

  final List<NovelData> _novelList = [
    NovelData('소설 제목1', '작가1', 'assets/images/novel1.jpg','1','1', '장르1',['태그1', '태그2', '태그3', '태그4' ,'태그5', '태그6', '태그7', '태그8']),
    NovelData('소설 제목2', '작가2', 'assets/images/novel2.jpg','2','2', '장르2'),
    NovelData('소설 제목3', '작가3', 'assets/images/novel3.jpg','3','3', '장르3'),
    NovelData('소설 제목4', '작가4', 'assets/images/novel4.jpg','4','4', '장르4'),
    NovelData('소설 제목5', '작가5', 'assets/images/novel5.jpg','5', '5', '장르5'),
  ];

  List<NovelData> get novelList => _novelList;

  bool isLoading = false;
  String? errorMessage;

  NovelViewModel() {
    initialize();
  }

  Future<void> initialize() async {
    isLoading = true;
    errorMessage = null;
    notifyListeners();

    try {
      // 초기화 작업 (예: API 호출 등)
      await Future.delayed(Duration(seconds: 1)); // 예시로 1초 대기
    } catch (e) {
      errorMessage = '초기화 실패: $e';
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }


  void removeNovel(int index) {
    _novelList.removeAt(index);
    notifyListeners();
  }

  final List<Collection> _collectionList = [
    Collection('컬렉션 제목1', 'assets/images/collection1.jpg',
        [
          NovelData('소설 제목1', '작가1', 'assets/images/novel1.jpg,','1', '1', '장르1'),
          NovelData('소설 제목2', '작가2', 'assets/images/novel2.jpg,','2', '2', '장르2'),
        ]),
    Collection('컬렉션 제목2', 'assets/images/collection2.jpg'),
    Collection('컬렉션 제목3', 'assets/images/collection2.jpg'),
    Collection('컬렉션 제목4', 'assets/images/collection2.jpg'),
  ];

  List<Collection> get collectionList => _collectionList;


  void addCollection(title,imagePath){
    _collectionList.add(Collection(title, imagePath));
    notifyListeners();
  }
  void removeCollection(int index) {
    _collectionList.removeAt(index);
    notifyListeners();
  }

  void addNovelToCollection(int collectionIndex, NovelData novel) {
    _collectionList[collectionIndex].novels.add(novel);
    notifyListeners();
  }
  void removeNovelFromCollection(int collectionIndex, int novelIndex) {
    _collectionList.removeAt(novelIndex);
    notifyListeners();
  }

}