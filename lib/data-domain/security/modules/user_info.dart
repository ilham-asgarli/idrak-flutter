import 'package:emekteb/core/base/models/base_model.dart';

class UserInfo extends BaseModel<UserInfo> {
  String? code;
  String? message;
  Result? result;

  UserInfo({this.code, this.message, this.result});

  UserInfo.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];
    result = json['result'];
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['code'] = code;
    data['message'] = message;
    data['result'] = result;
    return data;
  }

  @override
  UserInfo fromJson(Map<String, dynamic> json) {
    return UserInfo(
      code: json["code"],
      message: json["message"],
      result: json['result'] != null ? Result.fromJson(json['result']) : null,
    );
  }
}

class Result {
  String? username;  Role? role;
  dynamic employee;
  Customer? customer;
  bool? active;
  String? lang;

  Result(
      {this.username,
      this.role,
      this.employee,
      this.customer,
      this.active,
      this.lang});

  Result.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    role = json['role'] != null ? Role.fromJson(json['role']) : null;
    employee = json['employee'];
    customer =
        json['customer'] != null ? Customer.fromJson(json['customer']) : null;
    active = json['active'];
    lang = json['lang'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['username'] = username;
    if (role != null) {
      data['role'] = role!.toJson();
    }
    data['employee'] = employee;
    if (customer != null) {
      data['customer'] = customer!.toJson();
    }
    data['active'] = active;
    data['lang'] = lang;
    return data;
  }
}

class Role {
  int? id;
  String? info;
  String? description;

  Role({this.id, this.info, this.description});

  Role.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    info = json['info'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['info'] = info;
    data['description'] = description;
    return data;
  }
}

class Customer {
  String? id;
  String? secondName;
  String? firstName;
  String? fatherName;
  String? matherName;
  Gender? gender;
  CustomerDocument? customerDocument;
  String? dob;
  dynamic email;
  String? mob1;
  String? mob2;
  String? fullName;

  Customer(
      {this.id,
      this.secondName,
      this.firstName,
      this.fatherName,
      this.matherName,
      this.gender,
      this.customerDocument,
      this.dob,
      this.email,
      this.mob1,
      this.mob2,
      this.fullName});

  Customer.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    secondName = json['secondName'];
    firstName = json['firstName'];
    fatherName = json['fatherName'];
    matherName = json['matherName'];
    gender = json['gender'] != null ? Gender.fromJson(json['gender']) : null;
    customerDocument = json['customerDocument'] != null
        ? CustomerDocument.fromJson(json['customerDocument'])
        : null;
    dob = json['dob'];
    email = json['email'];
    mob1 = json['mob1'];
    mob2 = json['mob2'];
    fullName = json['fullName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['secondName'] = secondName;
    data['firstName'] = firstName;
    data['fatherName'] = fatherName;
    data['matherName'] = matherName;
    if (gender != null) {
      data['gender'] = gender!.toJson();
    }
    if (customerDocument != null) {
      data['customerDocument'] = customerDocument!.toJson();
    }
    data['dob'] = dob;
    data['email'] = email;
    data['mob1'] = mob1;
    data['mob2'] = mob2;
    data['fullName'] = fullName;
    return data;
  }
}

class Gender {
  int? id;
  String? info;

  Gender({this.id, this.info});

  Gender.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    info = json['info'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['info'] = info;
    return data;
  }
}

class CustomerDocument {
  String? documentSeriya;
  String? documentFin;
  dynamic documentOrqan;
  dynamic documentGivenDate;
  dynamic registrationAdress;
  String? liveAdress;
  dynamic bloodGroup;
  dynamic height;
  dynamic eyeColor;

  CustomerDocument(
      {this.documentSeriya,
      this.documentFin,
      this.documentOrqan,
      this.documentGivenDate,
      this.registrationAdress,
      this.liveAdress,
      this.bloodGroup,
      this.height,
      this.eyeColor});

  CustomerDocument.fromJson(Map<String, dynamic> json) {
    documentSeriya = json['documentSeriya'];
    documentFin = json['documentFin'];
    documentOrqan = json['documentOrqan'];
    documentGivenDate = json['documentGivenDate'];
    registrationAdress = json['registrationAdress'];
    liveAdress = json['liveAdress'];
    bloodGroup = json['bloodGroup'];
    height = json['height'];
    eyeColor = json['eyeColor'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['documentSeriya'] = documentSeriya;
    data['documentFin'] = documentFin;
    data['documentOrqan'] = documentOrqan;
    data['documentGivenDate'] = documentGivenDate;
    data['registrationAdress'] = registrationAdress;
    data['liveAdress'] = liveAdress;
    data['bloodGroup'] = bloodGroup;
    data['height'] = height;
    data['eyeColor'] = eyeColor;
    return data;
  }
}
