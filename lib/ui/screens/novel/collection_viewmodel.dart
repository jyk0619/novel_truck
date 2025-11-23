
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:novel_truck/data/model/collection_model.dart';
import 'package:novel_truck/data/model/novel_model.dart';
import 'package:novel_truck/data/repository/collection_repository.dart';


class CollectionViewModel extends ChangeNotifier {
  final CollectionRepository _repository= CollectionRepository();
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? errorMessage;

  final List<Collection> _collectionList = [];
  List<Collection> get collectionList => _collectionList;

  final List<NovelData> _collectionNovelList = [];
  List<NovelData> get collectionNovelList => _collectionNovelList;

  CollectionViewModel() {
    initialize();
  }

  Future<void> initialize() async {
    await fetchCollectionList();
  }

  Future<void> initializeCollectionNovels(int collectionId) async {
    await fetchCollectionNovelList(collectionId);
  }

  Future<void> fetchCollectionList() async {
    _isLoading = true;
    errorMessage = null;
    _collectionList.clear();
    notifyListeners();

    try {
      final collections = await _repository.fetchCollectionList();
      _collectionList.addAll(collections);
    } catch (e) {
      errorMessage = '컬렉션을 불러오는 데 실패했습니다: $e';
      print(errorMessage);
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> fetchCollectionNovelList(int collectionId) async {
    _isLoading = true;
    errorMessage = null;
    _collectionNovelList.clear();
    notifyListeners();

    try {
      final novels = await _repository.fetchCollectionNovelList(collectionId);
      _collectionNovelList.addAll(novels);
    } catch (e) {
      errorMessage = '컬렉션 소설을 불러오는 데 실패했습니다: $e';
      print(errorMessage);
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }


  Future<void> submitCollection(String title, File imageFile) async {
    try {
      _isLoading = true;
      notifyListeners();

      await _repository.addCollection(title: title, imageFile: imageFile);

      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      errorMessage = e.toString();
      notifyListeners();
    }
  }

  Future<void> addNovelToCollection(int collectionId, novelId) async {
    try {
      _isLoading = true;
      notifyListeners();

      await _repository.addNovelToCollection(
          collectionId: collectionId, novelId: novelId);

      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      errorMessage = e.toString();
      notifyListeners();
    }
    finally{
      await fetchCollectionNovelList(collectionId);
    }
  }

  Future<void> removeCollection(int collectionId) async {
    try{
      _isLoading = true;
      notifyListeners();

      await _repository.removeCollection(collectionId);

    } catch (e) {
      errorMessage = e.toString();
    } finally {
      await fetchCollectionList();
      _isLoading = false;
    }

    notifyListeners();
  }

  Future<void> editCollection(int id, String title, File imageFile) async {
    try {
      _isLoading = true;
      notifyListeners();

      await _repository.editCollection(id:id, title: title, imageFile: imageFile);

      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      errorMessage = e.toString();
      notifyListeners();
    }
  }

  void removeNovelFromCollection(int collectionIndex, int novelIndex) {
    _collectionList.removeAt(novelIndex);
    notifyListeners();
  }

}