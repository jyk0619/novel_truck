
import '../datasource/novel_api_service.dart';
import '../model/novel_model.dart';

class NovelRepository {
  final _apiService = NovelApiService();

  Future<NovelResponseModel> submitNovel(String url) async {
    try{
      final json = await _apiService.postNovelUrl(url);

      return NovelResponseModel.fromJson(json['data']);
    }
    catch(e){
      print('레포지토리 - 에러: $e');
      rethrow;
    }

  }

  Future<NovelListResponseModel> fetchNovelList() async {
    final jsonList = await _apiService.getNovelList();
    return NovelListResponseModel.fromJson(jsonList);
  }
}
