class CollectionListResponse {
  final int code;
  final List<Collection> data;

  CollectionListResponse({
    required this.code,
    required this.data,
  });

  factory CollectionListResponse.fromJson(Map<String, dynamic> json) {
    return CollectionListResponse(
      code: json['code'] ?? 0,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => Collection.fromJson(e))
          .toList() ??
          [],
    );
  }
}

class Collection {
  final int id;
  final String title;
  final String description;
  final String thumbnail;
  final bool isPublic;
  final int userId;
  final DateTime createdAt;
  final DateTime updatedAt;
  final Count count;

  Collection({
    required this.id,
    required this.title,
    required this.description,
    required this.thumbnail,
    required this.isPublic,
    required this.userId,
    required this.createdAt,
    required this.updatedAt,
    required this.count,
  });

  factory Collection.fromJson(Map<String, dynamic> json) {
    return Collection(
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      thumbnail: json['thumbnail'] ?? '',
      isPublic: json['isPublic'] ?? false,
      userId: json['userId'] ?? 0,
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      count: Count.fromJson(json['_count'] ?? {}),
    );
  }
}

class Count {
  final int novels;

  Count({required this.novels});

  factory Count.fromJson(Map<String, dynamic> json) {
    return Count(
      novels: json['novels'] ?? 0,
    );
  }
}
