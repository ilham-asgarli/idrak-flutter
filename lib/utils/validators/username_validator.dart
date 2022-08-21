class UsernameValidator {
  String? username;

  UsernameValidator(this.username);

  String? validate() {
    if(username != null && username!.isNotEmpty) {
      return null;
    } else {
      return "İstifadəçi adı girin";
    }
  }
}