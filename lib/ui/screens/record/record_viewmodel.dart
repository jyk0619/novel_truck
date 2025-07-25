import 'package:flutter/material.dart';
import 'package:novel_truck/data/model/record_model.dart';


class RecordViewModel extends ChangeNotifier {

  bool _isLoading = true;
  bool get isLoading => _isLoading;

  RecordViewModel() {
    _initialize();
  }

  Future<void> _initialize() async {
    await Future.delayed(Duration(seconds: 1)); // 로딩 시간
    _isLoading = false;
    notifyListeners();
  }

  final List<RecordData> _recordData = [
    RecordData(id: '1', novelId: 'novel1', tag: ['tag1', 'tag2'], isBookmarked: false, content: '기록 내용 aaaaaa\na\naaaaaa\naaa\naaa\naaa\naaaaa\naaaaaas\ndfasdfas\ndfasdfasdfasdfa\nadafsdfdfa\naaaa1'),
    RecordData(id: '2', novelId: 'novel2', tag: ['tag3', 'tag4'], isBookmarked: false, content: '기록 내용 2'),
    RecordData(id: '3', novelId: 'novel3', tag: ['tag5', 'tag6'], isBookmarked: false, content: '기록 내용 3'),
    RecordData(id: '4', novelId: 'novel4', tag: ['tag7', 'tag8'], isBookmarked: false, content: '기록 내용 4'),
    RecordData(id: '5', novelId: 'novel5', tag: ['tag9', 'tag10'], isBookmarked: false, content: '기록 내용 5'),
  ];

  List<RecordData> _filteredRecordData = [];

  // 검색 텍스트를 관리하는 controller
  TextEditingController searchController = TextEditingController();

  List<RecordData> get recordData => _filteredRecordData.isEmpty ? _recordData : _filteredRecordData;

  void searchRecord(String query) {
    if (query.isEmpty) {
      _filteredRecordData = [];
    } else {
      _filteredRecordData = _recordData
          .where((record) =>
      record.content != null && record.content!.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }
    notifyListeners(); // 검색 결과가 변경되었으므로 UI를 갱신
  }

  //기록 검색

  // 인덱스를 지정해서 수정
  void setRecordId(int index, String id) {
    _recordData[index].id = id;
    notifyListeners();
  }

  void setNovelId(int index, String novelId) {
    _recordData[index].novelId = novelId;
    notifyListeners();
  }

  void setTag(int index, List<String> tag) {
    _recordData[index].tag = tag;
    notifyListeners();
  }

  void setContent(int index, String content) {
    _recordData[index].content = content;
    notifyListeners();
  }

  void addBookmark(int index) {
    _recordData[index].isBookmarked = !_recordData[index].isBookmarked;
    notifyListeners();
  }
}
