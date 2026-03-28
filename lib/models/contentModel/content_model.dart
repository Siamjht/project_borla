class ContentPageModel {
  final String key;
  final String content;

  ContentPageModel({required this.key, required this.content});

  factory ContentPageModel.fromJson(Map<String, dynamic> json) {
    return ContentPageModel(
      key: json['key'] ?? '',
      content: json['content'] ?? '',
    );
  }
}