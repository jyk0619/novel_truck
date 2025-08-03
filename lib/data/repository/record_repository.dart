
import '../datasource/record_api_service.dart';
import '../model/record_model.dart';

class RecordRepository {
  final _apiService = RecordApiService();

  Future<RecordResponseModel> submitRecord() async {
    try{
      final json = await _apiService.postRecord(
        'novelId', // 여기에 실제 novelId를 넣어야 합니다.
        '기록 내용' // 여기에 실제 기록 내용을 넣어야 합니다.
      );

      return RecordResponseModel.fromJson(json['data']);
    }
    catch(e){
      print('레포지토리 - 에러: $e');
      rethrow;
    }

  }

  Future<RecordListResponseModel> fetchRecordList() async {
    final jsonList = await _apiService.getRecordList();
    print('레포지토리 - jsonList: $jsonList');
    return RecordListResponseModel.fromJson(jsonList);
  }
}
