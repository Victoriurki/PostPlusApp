// ignore_for_file: unnecessary_this, prefer_collection_literals

class UserModel {
  String? firstName;
  String? lastName;
  String? email;
  String? password;
  String? sId;
  String? token;
  String? profilePicture;
  List<dynamic>? following;
  List<dynamic>? followers;
  List<dynamic>? pictures;

  UserModel({
    this.firstName,
    this.lastName,
    this.email,
    this.password,
    this.sId,
    this.token,
    this.followers,
    this.following,
    this.pictures,
    this.profilePicture,
  });

  UserModel.fromJson(Map<String, dynamic> json) {
    firstName = json['first_name'];
    lastName = json['last_name'];
    email = json['email'];
    password = json['password'];
    sId = json['_id'];
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['email'] = this.email;
    data['password'] = this.password;
    data['_id'] = this.sId;
    data['token'] = this.token;
    return data;
  }
}
