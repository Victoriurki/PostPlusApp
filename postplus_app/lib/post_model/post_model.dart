class PostModel {
  String? url;
  String? description;
  String? id;
  String? ownerId;
  List<dynamic>? likes;

  PostModel({
    this.url,
    this.description,
    this.id,
    this.likes,
    this.ownerId
  });

  factory PostModel.fromJson(Map<String, dynamic> map) {
    return PostModel(
      url: map["url"] ?? "",
      description: map["description"] ?? "",
      id: map["_id"] ?? "",
      likes: map["likes"] ?? [],
      ownerId: map["owner_id"] ?? "",
    );
  }
}
