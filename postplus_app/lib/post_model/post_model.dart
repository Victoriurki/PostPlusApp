import '../owner_model/my_owner_model.dart';

class PostModel {
  String? url;
  String? description;
  String? id;
  OwnerModel? ownerData;
  List<dynamic>? likes;

  PostModel({
    this.url,
    this.description,
    this.id,
    this.likes,
    this.ownerData,
  });

  factory PostModel.fromJson(Map<String, dynamic> map) {
    return PostModel(
      url: map["url"] ?? "",
      description: map["description"] ?? "",
      id: map["_id"] ?? "",
      ownerData: OwnerModel.fromJson(map['owner_data']),
      likes: map["likes"] ?? [],
    );
  }
}
