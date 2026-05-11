class AccountModel {
  final String id;
  final String username;
  final String email;
  final String phone;
  final String role;

  AccountModel({
    required this.id,
    required this.username,
    required this.email,
    required this.phone,
    required this.role,
  });

  factory AccountModel.fromJson(Map<String, dynamic> json) {
    return AccountModel(
      id: json['id'],
      username: json['username'],
      email: json['email'],
      phone: json['phone'],
      role: json['role'],
    );
  }
}
