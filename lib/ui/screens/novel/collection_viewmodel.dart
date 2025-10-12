
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:novel_truck/data/model/collection_model.dart';
import 'package:novel_truck/data/model/novel_model.dart';
import 'package:novel_truck/data/repository/collection_repository.dart';


class CollectionViewModel extends ChangeNotifier {
  final CollectionRepository _repository = CollectionRepository();
  bool isLoading = false;
  String? errorMessage;


  Future<void> initialize() async {
    // 초기화 로직이 필요하다면 여기에 작성
    notifyListeners();
  }

  final List<Collection> _collectionList = [];

  List<Collection> get collectionList => _collectionList;


  Future<void> submitCollection(String title, File imageFile) async {
    try {
      isLoading = true;
      notifyListeners();

      await _repository.addCollection(title: title, imageFile: imageFile);

      isLoading = false;
      notifyListeners();
    } catch (e) {
      isLoading = false;
      errorMessage = e.toString();
      notifyListeners();
    }
  }

  void removeCollection(int index) {
    _collectionList.removeAt(index);
    notifyListeners();
  }

  // void addNovelToCollection(int collectionIndex, NovelData novel) {
  //   _collectionList[collectionIndex].novels.add(novel);
  //   notifyListeners();
  // }
  void removeNovelFromCollection(int collectionIndex, int novelIndex) {
    _collectionList.removeAt(novelIndex);
    notifyListeners();
  }

}