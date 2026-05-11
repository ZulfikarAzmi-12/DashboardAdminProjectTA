class DamageReportModel {
  final String id;
  final String title;
  final String status;
  final UserModel user;
  final UnitModel unit;

  DamageReportModel({
    required this.id,
    required this.title,
    required this.status,
    required this.user,
    required this.unit,
  });

  factory DamageReportModel.fromJson(Map<String, dynamic> json) {
    return DamageReportModel(
      id: json['id'],
      title: json['title'],
      status: json['status'],
      user: UserModel.fromJson(json['user']),
      unit: UnitModel.fromJson(json['unit']),
    );
  }
}

class UserModel {
  final String id;
  final String username;
  final String phone;

  UserModel({required this.id, required this.username, required this.phone});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      username: json['username'],
      phone: json['phone'],
    );
  }
}

class UnitModel {
  final String itemUnitCode;
  final String itemName;

  UnitModel({required this.itemUnitCode, required this.itemName});

  factory UnitModel.fromJson(Map<String, dynamic> json) {
    return UnitModel(
      itemUnitCode: json['itemUnitCode'],
      itemName: json['itemName'],
    );
  }
}
