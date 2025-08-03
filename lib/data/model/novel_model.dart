
class NovelData{
  final String title;
  final String author;
  final String imgPath;
  final String id;
  final String genreId;
  final String genreName;
  final String description;
  final List<String> tags;



  NovelData(this.title,
      this.author,
      this.imgPath,
      this.id,
      this.genreId,
      this.genreName,
      this.description, [List<String>? tags])
      : tags = tags ?? [];

  factory NovelData.fromResponse(NovelResponseModel response) {
    return NovelData(
      response.title,
      response.author,
      response.imgpath,
      response.id,
      response.genreId,
      response.genreName,
      response.description,
      response.tags,
    );
  }

}


//노벨 전체 리스트 응답 모델
class NovelListResponseModel {
  final List<NovelResponseModel> items;
  final int total;
  final int totalPages;
  final bool hasNext;

  NovelListResponseModel({
    required this.items,
    required this.total,
    required this.totalPages,
    required this.hasNext,
  });

  factory NovelListResponseModel.fromJson(Map<String, dynamic> json) {
    final data = json['data'] ?? {};
    final itemsJson = data['items'] as List<dynamic>? ?? [];

    return NovelListResponseModel(
      items: itemsJson.map((e) => NovelResponseModel.fromJson(e)).toList(),
      total: data['total'] ?? 0,
      totalPages: data['totalPages'] ?? 0,
      hasNext: data['hasNext'] ?? false,
    );
  }
}


//노벨 응답 모델
class NovelResponseModel {
  final String id;
  final String title;
  final String imgpath;
  final String genreId;
  final String genreName;
  final String description;
  final String author;
  final List<String> tags;

  NovelResponseModel({
    required this.id,
    required this.title,
    required this.imgpath,
    required this.genreId,
    required this.genreName,
    required this.description,
    this.author = '',
    this.tags = const [],
  });

  factory NovelResponseModel.fromJson(Map<String, dynamic> json) {

    final genres = json['genres'];
    final isGenresValid = genres is List && genres.isNotEmpty;
    //장르 null 체크 및 유효성 검사

    return NovelResponseModel(
      id: json['id']?.toString() ?? '',
      title: json['title']?.toString() ?? '',
      imgpath: json['coverImageUrl']?.toString() ?? '',
      genreId: isGenresValid ? genres[0]['id'].toString() : '',
      genreName: isGenresValid ? genres[0]['name'].toString() : '',
      description: json['description']?.toString() ?? '',
      tags: List<String>.from(json['tags']?.map((tag) => tag['name'].toString()) ?? []),
      author: json['author']?['name']?.toString() ?? '',
    );
  }


  NovelData toDomain() {
    return NovelData(
      title,
      author,
      imgpath,
      id,
      genreId,
      genreName,
      description,
      tags,
    );
  }


}
