class LoanDetailModel {
  final String id;
  final String status;
  final String loanCode;
  final String borrowedDate;
  final String returnDate;
  final LoanUnitModel unit;
  final LoanUserModel user;
  final String purpose;

  LoanDetailModel({
    required this.id,
    required this.status,
    required this.loanCode,
    required this.borrowedDate,
    required this.returnDate,
    required this.unit,
    required this.user,
    required this.purpose,
  });

  factory LoanDetailModel.fromJson(Map<String, dynamic> json) {
    return LoanDetailModel(
      id: json['id'] as String,
      status: json['status'] as String,
      loanCode: json['loanCode'] as String,
      borrowedDate: json['borrowedDate'] as String,
      returnDate: json['returnDate'] as String,
      unit: LoanUnitModel.fromJson(json['unit'] as Map<String, dynamic>),
      user: LoanUserModel.fromJson(json['user'] as Map<String, dynamic>),
      purpose: json['purpose'] as String,
    );
  }

  // ── Convenience getters (dipakai di page) ─────────────────────────────────
  String get borrowDate => borrowedDate;
  String get itemName => unit.item.name;
  String get itemCode => unit.itemUnitCode;
  String get imageUrl => unit.item.image;
  String get borrowerName => user.username;
  String get borrowerPhone => user.phone;
  String get loanPurpose => purpose;
}

// ─────────────────────────────────────────────────────────────────────────────

class LoanUnitModel {
  final String id;
  final String itemUnitCode;
  final String status;
  final LoanItemModel item;

  LoanUnitModel({
    required this.id,
    required this.itemUnitCode,
    required this.status,
    required this.item,
  });

  factory LoanUnitModel.fromJson(Map<String, dynamic> json) {
    return LoanUnitModel(
      id: json['id'] as String,
      itemUnitCode: json['itemUnitCode'] as String,
      status: json['status'] as String,
      item: LoanItemModel.fromJson(json['item'] as Map<String, dynamic>),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────

class LoanItemModel {
  final String name;
  final String location;
  final String image;

  LoanItemModel({
    required this.name,
    required this.location,
    required this.image,
  });

  factory LoanItemModel.fromJson(Map<String, dynamic> json) {
    return LoanItemModel(
      name: json['name'] as String,
      location: json['location'] as String,
      image: json['image'] as String,
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────

class LoanUserModel {
  final String username;
  final String phone;

  LoanUserModel({required this.username, required this.phone});

  factory LoanUserModel.fromJson(Map<String, dynamic> json) {
    return LoanUserModel(
      username: json['username'] as String,
      phone: json['phone'] as String,
    );
  }
}
