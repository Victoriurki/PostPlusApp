// ignore_for_file: unnecessary_this, prefer_collection_literals

class UserModel {
  String? firstName;
  String? lastName;
  String? email;
  String? password;
  String? sId;
  String? token;
  String? profilePicture;
  String? biography;
  String? username;
  List<dynamic>? following;
  List<dynamic>? followers;

  UserModel({
    this.firstName,
    this.lastName,
    this.email,
    this.password,
    this.sId,
    this.token,
    this.followers,
    this.following,
    this.profilePicture,
    this.biography,
    this.username,
  });

  UserModel.fromJson(Map<String, dynamic> json) {
    firstName = json['first_name'] ?? "";
    lastName = json['last_name'] ?? "";
    email = json['email'] ?? "";
    password = json['password'] ?? "";
    sId = json['_id'] ?? "";
    token = json['token'] ?? "";
    profilePicture = json['profile_picture'] ?? "";
    biography = json['biography'] ?? "";
    username = json['username'] ?? "";
    followers = json['followers'] ?? [];
    following = json['following'] ?? [];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['email'] = this.email;
    data['password'] = this.password;
    data['_id'] = this.sId;
    data['profile_picture'] = this.token;
    data['biography'] = this.biography;
    data['followers'] = this.followers;
    data['following'] = this.following;
    data['username'] = this.username;
    return data;
  }
}
