class RecordResponseModel {
  final int? id;
  final int? userId;
  final int? novelId;
  final String? content;
  final DateTime? createdAt;

  RecordResponseModel({
    this.id,
    this.userId,
    this.novelId,
    this.content,
    this.createdAt,
  });

  factory RecordResponseModel.fromJson(Map<String, dynamic> json) {
    return RecordResponseModel(
      id: json['id'],
      userId: json['userId'],
      novelId: json['novelId'],
      content: json['content'],
      createdAt: json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
    );
  }
}

class RecordData {
  int? id;
  int? userId;
  int? novelId;
  String? content;
  DateTime? date;

  RecordData({
    this.id,
    this.userId,
    this.novelId,
    this.content,
    this.date,
  });

  factory RecordData.fromResponse(RecordResponseModel response) {
    return RecordData(
      id: response.id,
      userId: response.userId,
      novelId: response.novelId,
      content: response.content,
      date: response.createdAt,
    );
  }
}

class RecordListResponseModel {
  final List<RecordResponseModel> items;
  final int total;
  final int totalPages;
  final bool hasNext;

  RecordListResponseModel({
    required this.items,
    required this.total,
    required this.totalPages,
    required this.hasNext,
  });

  factory RecordListResponseModel.fromJson(Map<String, dynamic> json) {
    final data = json['data'] ?? {};
    final itemsJson = data['items'] as List<dynamic>? ?? [];

    return RecordListResponseModel(
      items: itemsJson.map((item) => RecordResponseModel.fromJson(item)).toList(),
      total: data['total'] ?? 0,
      totalPages: data['totalPages'] ?? 0,
      hasNext: data['hasNextPage'] ?? false, // 🔧 여기 중요
    );
  }
}
