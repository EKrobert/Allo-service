class User {
  String firstname;
  String lastname;
  String email;
  String phone;
  String username;
  String password;
  String role;

  User({
    required this.firstname,
    required this.lastname,
    required this.email,
    required this.phone,
    required this.username,
    required this.password,
    required this.role,
  });

  Map<String, dynamic> toJson() {
    return {
      'firstname': firstname,
      'lastname': lastname,
      'email': email,
      'phone': phone,
      'username': username,
      'password': password,
      'role': role,
    };
  }
}
