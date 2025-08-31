
import '../datasource/genre_api_service.dart';
import '../model/genre_model.dart';

class GenreRepository {
  final _apiService = GenreApiService();

  Future<GenreListResponseModel> fetchRecordList() async {
    final jsonList = await _apiService.getRecordList();
    return GenreListResponseModel.fromJson(jsonList);
  }

}
