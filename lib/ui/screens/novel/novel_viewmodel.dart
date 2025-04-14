

import 'package:flutter/foundation.dart';
import 'package:novel_truck/data/model/novel_model.dart';

class NovelViewModel extends ChangeNotifier {
  final List<NovelData> _novelList = [
    NovelData('소설 제목1', '작가1', 'assets/images/novel1.jpg'),
    NovelData('소설 제목2', '작가2', 'assets/images/novel2.jpg'),
    NovelData('소설 제목3', '작가3', 'assets/images/novel3.jpg'),
    NovelData('소설 제목4', '작가4', 'assets/images/novel4.jpg'),
    NovelData('소설 제목5', '작가5', 'assets/images/novel5.jpg'),
  ];

  List<NovelData> get novelList => _novelList;

  void addNovel(NovelData novel) {
    _novelList.add(novel);
    notifyListeners();
  }

  void removeNovel(int index) {
    _novelList.removeAt(index);
    notifyListeners();
  }

  final List<Collection> _collectionList = [
    Collection('컬렉션 제목1', 'assets/images/collection1.jpg',
        [
          NovelData('소설 제목1', '작가1', 'assets/images/novel1.jpg'),
          NovelData('소설 제목2', '작가2', 'assets/images/novel2.jpg'),
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