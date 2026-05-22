import 'dart:convert';

class UserModel {
  bool? status;
  UserData? user;

  UserModel({this.status, this.user});

  // تحويل من JSON إلى Model
  UserModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    user = json['user'] != null ? UserData.fromJson(json['user']) : null;
  }

  // تحويل من Model إلى JSON
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (user != null) {
      data['user'] = user!.toJson();
    }
    return data;
  }
}

class UserData {
  int? id;
  String? name;
  String? firstName;
  String? lastName;
  String? email;
  String? username;
  String? phone;
  String? gender; // تم تعريفه كـ String لأنه غالباً يعود بنص عند تعبئته
  String? image;

  UserData({
    this.id,
    this.name,
    this.firstName,
    this.lastName,
    this.email,
    this.username,
    this.phone,
    this.gender,
    this.image,
  });

  // تحويل من JSON إلى Model لكل حقول المستخدم
  UserData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    email = json['email'];
    username = json['username'];
    phone = json['phone'];
    gender = json['gender'];
    image = json['image'];
  }

  // تحويل من Model إلى JSON لكل حقول المستخدم
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['email'] = email;
    data['username'] = username;
    data['phone'] = phone;
    data['gender'] = gender;
    data['image'] = image;
    return data;
  }
}