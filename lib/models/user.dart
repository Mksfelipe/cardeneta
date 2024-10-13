class User {
  final int id;
  final String firstName;
  final String lastName;
  final String email;
  final DateTime created;
  final DateTime updated;
  final String cpf;
  final String? contact;

  User({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.created,
    required this.updated,
    required this.cpf,
    this.contact,
  });

  // Método para criar um User a partir de um JSON
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      email: json['email'],
      created: DateTime.parse(json['created']),
      updated: DateTime.parse(json['updated']),
      cpf: json['cpf'],
      contact: json['contact'],
    );
  }

  // Método para converter um User em JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'created': created.toIso8601String(),
      'updated': updated.toIso8601String(),
      'cpf': cpf,
      'contact': contact,
    };
  }
}
