
import '../datasource/record_api_service.dart';
import '../model/record_model.dart';

class RecordRepository {
  final _apiService = RecordApiService();

  Future<RecordResponseModel> submitRecord(
    int novelId, // 여기에 실제 novelId를 넣어야 합니다.
    String content, // 여기에 실제 기록 내용을 넣어야 합니다.
      ) async {
    try{
      final json = await _apiService.postRecord(
        novelId,
        content,
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
    return RecordListResponseModel.fromJson(jsonList);
  }
}
