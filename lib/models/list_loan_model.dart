class ListLoanModel {
  final String code;
  final String name;
  final String returnDate;
  final String status;
  final String image;

  ListLoanModel({
    required this.code,
    required this.name,
    required this.returnDate,
    required this.status,
    required this.image,
  });

  factory ListLoanModel.fromJson(
    Map<String, dynamic> json,
  ) {
    return ListLoanModel(
      code: json['code'] ?? '',
      name: json['name'] ?? '',
      returnDate:
          json['return_date'] ?? '',
      status: json['status'] ?? '',
      image: json['image'] ?? '',
    );
  }
}