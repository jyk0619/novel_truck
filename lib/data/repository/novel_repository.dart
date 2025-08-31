
import '../datasource/novel_api_service.dart';
import '../model/novel_model.dart';
import '../model/genre_model.dart';

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

  Future<NovelResponseModel> postTag(String tagName, int novelId) async {
    try{
      final json = await _apiService.postTag(tagName, novelId);
      return NovelResponseModel.fromJson(json['data']);
    }
    catch(e){
      print('레포지토리 - 에러: $e');
      rethrow;
    }
  }

  Future<GenreListResponseModel> fetchGenreList() async {
    final jsonList = await _apiService.getGenreList();

    return GenreListResponseModel.fromJson(jsonList);
  }
}
