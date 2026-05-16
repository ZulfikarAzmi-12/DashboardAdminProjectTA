class LoanDetailModel {
  final String status;
  final String loanCode;
  final String borrowDate;
  final String returnDate;
  final String itemName;
  final String itemCode;
  final String borrowerName;
  final String borrowerPhone;
  final String loanPurpose;
  final String imageUrl;

  LoanDetailModel({
    required this.status,
    required this.loanCode,
    required this.borrowDate,
    required this.returnDate,
    required this.itemName,
    required this.itemCode,
    required this.borrowerName,
    required this.borrowerPhone,
    required this.loanPurpose,
    required this.imageUrl,
  });

  factory LoanDetailModel.fromJson(Map<String, dynamic> json) {
    return LoanDetailModel(
      status: json['status'] ?? '',
      loanCode: json['loan_code'] ?? '',
      borrowDate: json['borrow_date'] ?? '',
      returnDate: json['return_date'] ?? '',
      itemName: json['item_name'] ?? '',
      itemCode: json['item_code'] ?? '',
      borrowerName: json['borrower_name'] ?? '',
      borrowerPhone: json['borrower_phone'] ?? '',
      loanPurpose: json['loan_purpose'] ?? '',
      imageUrl: json['image_url'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'loan_code': loanCode,
      'borrow_date': borrowDate,
      'return_date': returnDate,
      'item_name': itemName,
      'item_code': itemCode,
      'borrower_name': borrowerName,
      'borrower_phone': borrowerPhone,
      'loan_purpose': loanPurpose,
      'image_url': imageUrl,
    };
  }

  LoanDetailModel copyWith({
    String? status,
    String? loanCode,
    String? borrowDate,
    String? returnDate,
    String? itemName,
    String? itemCode,
    String? borrowerName,
    String? borrowerPhone,
    String? loanPurpose,
    String? imageUrl,
  }) {
    return LoanDetailModel(
      status: status ?? this.status,
      loanCode: loanCode ?? this.loanCode,
      borrowDate: borrowDate ?? this.borrowDate,
      returnDate: returnDate ?? this.returnDate,
      itemName: itemName ?? this.itemName,
      itemCode: itemCode ?? this.itemCode,
      borrowerName: borrowerName ?? this.borrowerName,
      borrowerPhone: borrowerPhone ?? this.borrowerPhone,
      loanPurpose: loanPurpose ?? this.loanPurpose,
      imageUrl: imageUrl ?? this.imageUrl,
    );
  }
}