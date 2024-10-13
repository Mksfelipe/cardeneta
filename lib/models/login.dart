class Login {
  String cpf;
  String password;

  Login({required this.cpf, required this.password});

  // Factory method to create a User from JSON
  factory Login.fromJson(Map<String, dynamic> json) {
    return Login(
      cpf: json['cpf'],
      password: json['password'],
    );
  }

  // Method to convert User to JSON
  Map<String, dynamic> toJson() {
    return {
      'cpf': cpf,
      'password': password,
    };
  }
}
