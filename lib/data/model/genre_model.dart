class GenreResponseModel {
  final String? id;
  final String? name;

  GenreResponseModel({
    this.id,
    this.name,

  });

  factory GenreResponseModel.fromJson(Map<String, dynamic> json) {
    return GenreResponseModel(
      id: json['id'] as String?,
      name: json['name'] as String?,
    );
  }
}

class GenreData {
  String? id;
  String? name;

  GenreData({
    this.id,
    this.name,

  });

  factory GenreData.fromResponse(GenreResponseModel response) {
    return GenreData(
      id: response.id,
      name: response.name,
    );
  }
}

class GenreListResponseModel {
  final List<GenreResponseModel> data;

  GenreListResponseModel({
    required this.data,
  });

  factory GenreListResponseModel.fromJson(Map<String, dynamic> json) {
    final dataJson = json['data'] as List<dynamic>? ?? [];

    return GenreListResponseModel(
      data: dataJson.map((item) => GenreResponseModel.fromJson(item)).toList(),
    );
  }
}
