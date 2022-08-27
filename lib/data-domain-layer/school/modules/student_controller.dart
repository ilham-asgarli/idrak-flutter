import 'package:emekteb/core/base/models/base_model.dart';

class StudentController extends BaseModel<StudentController> {
  String? code;
  String? message;
  List<Result>? result;

  StudentController({this.code, this.message, this.result});

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['code'] = code;
    data['message'] = message;
    if (result != null) {
      data['result'] = result!.map((v) => v.toJson()).toList();
    }
    return data;
  }

  @override
  StudentController fromJson(Map<String, dynamic> json) {
    return StudentController(
      code: json['code'],
      message: json['message'],
      result: json["result"] != null
          ? List<Result>.from(json["result"].map((x) => Result.fromJson(x)))
          : null,
    );
  }
}

class Result {
  String? id;
  Customer? customer;
  Parent? parent;
  RelationalShip? relationalShip;

  Result({this.id, this.customer, this.parent, this.relationalShip});

  Result.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    customer =
        json['customer'] != null ? Customer.fromJson(json['customer']) : null;
    parent = json['parent'] != null ? Parent.fromJson(json['parent']) : null;
    relationalShip = json['relationalShip'] != null
        ? RelationalShip.fromJson(json['relationalShip'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    if (customer != null) {
      data['customer'] = customer!.toJson();
    }
    if (parent != null) {
      data['parent'] = parent!.toJson();
    }
    if (relationalShip != null) {
      data['relationalShip'] = relationalShip!.toJson();
    }
    return data;
  }
}

class Customer {
  String? id;
  String? secondName;
  String? firstName;
  String? fatherName;
  dynamic matherName;
  Gender? gender;
  dynamic customerDocument;
  String? dob;
  dynamic email;
  dynamic mob1;
  dynamic mob2;
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
    customerDocument = json['customerDocument'];
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
    data['customerDocument'] = customerDocument;
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

class Parent {
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

  Parent(
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

  Parent.fromJson(Map<String, dynamic> json) {
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

class RelationalShip {
  int? id;
  String? info;
  dynamic gender;

  RelationalShip({this.id, this.info, this.gender});

  RelationalShip.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    info = json['info'];
    gender = json['gender'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['info'] = info;
    data['gender'] = gender;
    return data;
  }
}
