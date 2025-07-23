
import '../datasource/novel_api_service.dart';
import '../model/novel_model.dart';

class NovelRepository {
  final _apiService = NovelApiService();

  Future<NovelResponseModel> submitNovel(String url) async {
    final json = await _apiService.postNovelUrl(url);
    return NovelResponseModel.fromJson(json);
  }

  Future<NovelListResponseModel> fetchNovelList() async {
    final jsonList = await _apiService.getNovelList();
    print('레포지토리 에서 소설 목록을 가져왔습니다');
    return NovelListResponseModel.fromJson(jsonList);
  }
}
