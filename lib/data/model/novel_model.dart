
class NovelData{
  final String title;
  final String author;
  final String imagePath;

  NovelData(this.title, this.author, this.imagePath);
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

