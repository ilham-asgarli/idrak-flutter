import 'package:emekteb/core/base/models/base_model.dart';

class LoginResponse extends BaseModel<LoginResponse> {
  String? code;
  String? message;
  Result? result;

  LoginResponse({this.code, this.message, this.result});

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['code'] = code;
    data['message'] = message;
    if (result != null) {
      data['result'] = result!.toJson();
    }
    return data;
  }

  @override
  LoginResponse fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      code: json['code'],
      message: json['message'],
      result: json['result'] != null ? Result.fromJson(json['result']) : null,
    );
  }
}

class Result {
  String? accessToken;
  String? refreshToken;
  User? user;

  Result({this.accessToken, this.refreshToken, this.user});

  Result.fromJson(Map<String, dynamic> json) {
    accessToken = json['accessToken'];
    refreshToken = json['refreshToken'];
    user = json['user'] != null ? User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['accessToken'] = accessToken;
    data['refreshToken'] = refreshToken;
    if (user != null) {
      data['user'] = user!.toJson();
    }
    return data;
  }
}

class User {
  String? username;
  String? role;
  String? fullName;
  List<Permissions>? permissions;
  String? page;
  String? lang;

  User(
      {this.username,
      this.role,
      this.fullName,
      this.permissions,
      this.page,
      this.lang});

  User.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    role = json['role'];
    fullName = json['fullName'];
    if (json['permissions'] != null) {
      permissions = <Permissions>[];
      json['permissions'].forEach((v) {
        permissions!.add(Permissions.fromJson(v));
      });
    }
    page = json['page'];
    lang = json['lang'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['username'] = username;
    data['role'] = role;
    data['fullName'] = fullName;
    if (permissions != null) {
      data['permissions'] = permissions!.map((v) => v.toJson()).toList();
    }
    data['page'] = page;
    data['lang'] = lang;
    return data;
  }
}

class Permissions {
  int? id;
  String? label;
  String? info;
  String? icon;
  List<SubItems>? subItems;

  Permissions({this.id, this.label, this.info, this.icon, this.subItems});

  Permissions.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    label = json['label'];
    info = json['info'];
    icon = json['icon'];
    if (json['subItems'] != null) {
      subItems = <SubItems>[];
      json['subItems'].forEach((v) {
        subItems!.add(SubItems.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['label'] = label;
    data['info'] = info;
    data['icon'] = icon;
    if (subItems != null) {
      data['subItems'] = subItems!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SubItems {
  int? id;
  String? label;
  String? info;
  String? link;
  int? parentId;

  SubItems({this.id, this.label, this.info, this.link, this.parentId});

  SubItems.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    label = json['label'];
    info = json['info'];
    link = json['link'];
    parentId = json['parentId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['label'] = label;
    data['info'] = info;
    data['link'] = link;
    data['parentId'] = parentId;
    return data;
  }
}
