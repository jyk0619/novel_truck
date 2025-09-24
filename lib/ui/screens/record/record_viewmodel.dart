import 'package:flutter/material.dart';
import 'package:novel_truck/data/model/record_model.dart';
import 'package:novel_truck/data/repository/record_repository.dart';


class RecordViewModel extends ChangeNotifier {

  final RecordRepository _recordRepository = RecordRepository();


  bool _isLoading = true;
  bool get isLoading => _isLoading;
  String? errorMessage;


  RecordViewModel() {
    _initialize();
  }

  Future<void> _initialize() async {
    _isLoading = true;

    try{
      await fetchRecordList();

    } catch (e) {
      print('초기화 실패: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> fetchRecordList() async {
    _isLoading = true;
    errorMessage = null;

    _recordData.clear(); // 데이터를 먼저 초기화
    notifyListeners();

    try {
      var record = await _recordRepository.fetchRecordList();
      _recordData.addAll(record.items.map((item) => RecordData.fromResponse(item)).toList());
      fetchBookMarkList();
    } catch (e) {
      errorMessage = '기록을 불러오는 데 실패했습니다.';
      print('기록 목록을 불러오는 데 실패했습니다: $e');
    } finally {

      // 데이터가 변경되었으므로 UI를 갱신
      _isLoading = false;
      notifyListeners();
    }
  }

  List<RecordData> _bookMarkData = [];
  List<RecordData> get bookMarkData => _bookMarkData;

  void fetchBookMarkList() {

    _bookMarkData=[]; // 데이터를 먼저 초기화

    _bookMarkData = _recordData
        .where((record) =>
    record.isBookmarked) // isBookmarked가 true인 항목만 필터링)
        .toList();
    //isbookmarked true 인값 필터링
     notifyListeners();
    // }
  }




  final List<RecordData> _recordData = [];

  List<RecordData> _filteredRecordData = [];

  // 검색 텍스트를 관리하는 controller
  TextEditingController recordSearchController = TextEditingController();

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
  }//기록 검색

  // 인덱스를 지정해서 수정
  void setRecordId(int index, int id) {
    _recordData[index].id = id;
    notifyListeners();
  }

  void setNovelId(int index, int novelId) {
    _recordData[index].novelId = novelId;
    notifyListeners();
  }


  void setContent(int index, String content) {
    _recordData[index].content = content;
    notifyListeners();
  }

  Future<void> fetchBookmark(int id) async{

    try{
      await _recordRepository.fetchBookMark(id);
      print('북마크 성공');
    }
    catch(e){
      print('북마크 실패: $e');
    }

    finally{
      fetchRecordList();
      notifyListeners();
    }
  }

}
