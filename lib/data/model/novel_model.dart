
class NovelData{
  final String title;
  final String author;
  final String imagePath;
  final String id;
  final String genreId;
  final String genreName;
  final List<String> tags;


  NovelData(this.title, this.author, this.imagePath,this.id,this.genreId, this.genreName, [List<String>? tags])
      : tags = tags ?? [];
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
    return NovelResponseModel(
      id: json['id']?.toString() ?? '',
      title: json['title']?.toString() ?? '',
      imgpath: json['coverImageUrl']?.toString() ?? '',
      genreId: json['genres'].isNotEmpty ? json['genres'][0]['id'].toString() : '',
      genreName: json['genres'].isNotEmpty ? json['genres'][0]['name'].toString() : '',
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
      tags,
    );
  }


}
