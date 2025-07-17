
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

class CollectionData{
  final String title;
  final String author;
  final String imagePath;

  CollectionData(this.title, this.author,this.imagePath );
}

class Collection {
  final String title;
  final String imagePath;
  final List<NovelData> novels;

  Collection(this.title, this.imagePath, [List<NovelData>? novels])
      : novels = novels ?? [];
}

class NovelResponseModel {
  final String id;
  final String title;
  final String imgpath;
  final String genreId;
  final String genreName;

  NovelResponseModel({required this.id, required this.title, required this.imgpath, required this.genreId, required this.genreName});

  factory NovelResponseModel.fromJson(Map<String, dynamic> json) {
    return NovelResponseModel(
      id: json['data']['id']?.toString() ?? '',
      title: json['data']['title']?.toString()??'',
      imgpath: json['data']['coverImage']?.toString()??'',
      genreId: json['data']['genres'][0]['id']?.toString() ?? '',
      genreName: json['data']['genres'][0]['name']?.toString() ?? '',


    );
  }
}

