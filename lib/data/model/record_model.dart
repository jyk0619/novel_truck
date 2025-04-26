
class RecordData {
  String? id;
  String? novelId;
  List<String> tag;
  String? content;
  DateTime? date;
  bool isBookmarked;


  RecordData({
    this.id,
    this.novelId,
    this.tag= const [],
    this.content,
    this.date,
    this.isBookmarked=false,
  });
}