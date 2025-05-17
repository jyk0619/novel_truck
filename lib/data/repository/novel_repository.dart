
import '../datasource/novel_api_service.dart';
import '../model/novel_model.dart';

class NovelRepository {
  final _apiService = NovelApiService();

  Future<NovelResponseModel> submitNovel(String url) async {
    final json = await _apiService.postNovelUrl(url);
    return NovelResponseModel.fromJson(json);
  }
}
