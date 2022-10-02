import 'package:emekteb/core/base/models/base_model.dart';

class Login extends BaseModel<Login> {
  String? username;
  String? password;

  Login();

  Login.filled(this.username, this.password);

  @override
  Login fromJson(Map<String, dynamic> json) {
    return Login.filled(json["username"], json["password"]);
  }

  @override
  Map<String, dynamic> toJson() => {
        "username": username,
        "password": password,
      };
}
