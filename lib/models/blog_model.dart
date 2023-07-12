import 'dart:convert';

class BlogModel {
  final String authorName;
  final String desc;
  final String title;
  final String imageUrl;
  BlogModel({
    required this.authorName,
    required this.desc,
    required this.title,
    required this.imageUrl,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'authorName': authorName});
    result.addAll({'desc': desc});
    result.addAll({'title': title});
    result.addAll({'imageUrl': imageUrl});

    return result;
  }

  factory BlogModel.fromMap(Map<String, dynamic> map) {
    return BlogModel(
      authorName: map['authorName'] ?? '',
      desc: map['desc'] ?? '',
      title: map['title'] ?? '',
      imageUrl: map['imageUrl'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory BlogModel.fromJson(String source) =>
      BlogModel.fromMap(json.decode(source));
}
