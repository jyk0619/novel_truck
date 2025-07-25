
import 'package:flutter/material.dart';
import 'package:novel_truck/data/model/collection_model.dart';
import 'package:novel_truck/data/model/novel_model.dart';

class CollectionViewModel extends ChangeNotifier {



  // 초기화 메소드
  CollectionViewModel() {
    initialize();
  }

  Future<void> initialize() async {
    // 초기화 로직이 필요하다면 여기에 작성
    notifyListeners();
  }



  final List<Collection> _collectionList = [
    Collection('컬렉션 제목1', 'assets/images/collection1.jpg',
        [
          NovelData('소설 제목1', '작가1', 'assets/images/novel1.jpg,','1', '1', '장르1',''),
          NovelData('소설 제목2', '작가2', 'assets/images/novel2.jpg,','2', '2', '장르2',''),
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