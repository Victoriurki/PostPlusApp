class OwnerModel {
  String? firstName;
  String? lastName;
  String? id;
  String? username;
  String? profilePicture;

  OwnerModel({
    this.firstName,
    this.lastName,
    this.id,
    this.username,
    this.profilePicture,
  });

  factory OwnerModel.fromJson(Map<String, dynamic> map) {
    return OwnerModel(
      firstName: map["first_name"] ?? "",
      lastName: map["last_name"] ?? "",
      id: map["_id"] ?? "",
      username: map["username"] ?? "",
      profilePicture: map["profile_picture"] ?? "",
    );
  }
}