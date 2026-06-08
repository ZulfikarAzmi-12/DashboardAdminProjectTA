class LoanData {
  final String id;
  final String loanCode;
  final User user;
  final Unit unit;
  final String borrowedDate;
  final String returnDate;
  final String status;
  final String? rejectionReason;

  LoanData({
    required this.id,
    required this.loanCode,
    required this.user,
    required this.unit,
    required this.borrowedDate,
    required this.returnDate,
    required this.status,
    this.rejectionReason,
  });

  factory LoanData.fromJson(Map<String, dynamic> json) {
    return LoanData(
      id: json['id'],
      loanCode: json['loanCode'],
      user: User.fromJson(json['user']),
      unit: Unit.fromJson(json['unit']),
      borrowedDate: json['borrowedDate'],
      returnDate: json['returnDate'],
      status: json['status'],
      rejectionReason: json['rejectionReason'],
    );
  }
}

class User {
  final String username;
  final String phone;

  User({required this.username, required this.phone});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(username: json['username'], phone: json['phone']);
  }
}

class Unit {
  final String itemUnitCode;
  final String status;
  final Item item;

  Unit({required this.itemUnitCode, required this.status, required this.item});

  factory Unit.fromJson(Map<String, dynamic> json) {
    return Unit(
      itemUnitCode: json['itemUnitCode'],
      status: json['status'],
      item: Item.fromJson(json['item']),
    );
  }
}

class Item {
  final String name;

  Item({required this.name});

  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(name: json['name']);
  }
}

class ScheduleModel {
  final String id;
  final String borrowedDate;
  final String returnDate;
  final String status;

  ScheduleModel({
    required this.id,
    required this.borrowedDate,
    required this.returnDate,
    required this.status,
  });

  factory ScheduleModel.fromJson(Map<String, dynamic> json) {
    return ScheduleModel(
      id: json['id'] ?? '',
      borrowedDate: json['borrowedDate'] ?? '',
      returnDate: json['returnDate'] ?? '',
      status: json['status'] ?? '',
    );
  }
}
