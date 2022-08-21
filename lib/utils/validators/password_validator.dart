class PasswordValidator {
  String? password;

  PasswordValidator(this.password);

  String? validate() {
    if(password != null && password!.isNotEmpty) {
      return null;
    } else {
      return "Şifrə girin";
    }
  }
}