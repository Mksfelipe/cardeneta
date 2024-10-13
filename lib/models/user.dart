class User {
  final int id;
  final String firstName;
  final String lastName;
  final String email;
  final DateTime created;
  final DateTime updated;
  final Account account;
  final String cpf;
  final String? contact;

  User({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.created,
    required this.updated,
    required this.account,
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
      account: Account.fromJson(json['account']),
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
      'account': account.toJson(),
      'cpf': cpf,
      'contact': contact,
    };
  }
}

class Account {
  final int id;
  final double balance;
  final double balanceWeek;
  final double balanceMonth;
  final DateTime created;
  final DateTime updated;

  Account({
    required this.id,
    required this.balance,
    required this.balanceWeek,
    required this.balanceMonth,
    required this.created,
    required this.updated,
  });

  // Método para criar um Account a partir de um JSON
  factory Account.fromJson(Map<String, dynamic> json) {
    return Account(
      id: json['id'],
      balance: (json['balance'] as num).toDouble(),
      balanceWeek: (json['balanceWeek'] as num).toDouble(),
      balanceMonth: (json['balanceMonth'] as num).toDouble(),
      created: DateTime.parse(json['created']),
      updated: DateTime.parse(json['updated']),
    );
  }

  // Método para converter um Account em JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'balance': balance,
      'balanceWeek': balanceWeek,
      'balanceMonth': balanceMonth,
      'created': created.toIso8601String(),
      'updated': updated.toIso8601String(),
    };
  }
}
