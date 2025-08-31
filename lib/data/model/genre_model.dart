class GenreResponseModel {
  final int? id;
  final int? name;


  GenreResponseModel({
    this.id,
    this.name,

  });

  factory GenreResponseModel.fromJson(Map<String, dynamic> json) {
    return GenreResponseModel(
      id: json['id'],
      name: json['userId'],
    );
  }
}

class GenreData {
  int? id;
  int? name;


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
