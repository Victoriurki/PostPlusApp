class PostModel {
  String? url;
  String? description;
  String? id;
  List<dynamic>? likes;

  PostModel({
    this.url,
    this.description,
    this.id,
    this.likes,
  });

  factory PostModel.fromJson(Map<String, dynamic> map) {
    return PostModel(
      url: map["url"] ?? "",
      description: map["description"] ?? "",
      id: map["id"] ?? "",
      likes: map["likes"] ?? [],
    );
  }
}
