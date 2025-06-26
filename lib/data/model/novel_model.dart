
class NovelData{
  final String title;
  final String author;
  final String imagePath;
  final String id;

  NovelData(this.title, this.author, this.imagePath,this.id);
}

class CollectionData{
  final String title;
  final String author;
  final String imagePath;

  CollectionData(this.title, this.author,this.imagePath);
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

  NovelResponseModel({required this.id, required this.title, required this.imgpath});

  factory NovelResponseModel.fromJson(Map<String, dynamic> json) {
    return NovelResponseModel(
      id: json['data']['id']?.toString() ?? '', // <- 여기 중요!
      title: json['data']['title']?.toString()??'',
      imgpath: json['data']['coverImageUrl']?.toString()??'',

    );
  }
}

