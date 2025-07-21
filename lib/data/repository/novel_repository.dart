
import '../datasource/novel_api_service.dart';
import '../model/novel_model.dart';

class NovelRepository {
  final _apiService = NovelApiService();

  Future<NovelResponseModel> submitNovel(String url) async {
    final json = await _apiService.postNovelUrl(url);
    return NovelResponseModel.fromJson(json);
  }

  Future<List<NovelData>> fetchNovelList() async {
    final jsonList = await _apiService.getNovelList();
    print('Fetched novel list: $jsonList');
    return jsonList
        .map((json) => NovelResponseModel.fromJson(json).toDomain())
        .toList();
  }
}
