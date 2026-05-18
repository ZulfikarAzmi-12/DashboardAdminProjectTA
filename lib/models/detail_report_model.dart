class DetailReportModel {
  final String status;
  final String itemName;
  final String itemCode;
  final String imageUrl;
  final String borrowerName;
  final String reason;

  DetailReportModel({
    required this.status,
    required this.itemName,
    required this.itemCode,
    required this.imageUrl,
    required this.borrowerName,
    required this.reason,
  });

  factory DetailReportModel.fromJson(Map<String, dynamic> json) {
    return DetailReportModel(
      status: json['status'] ?? '',
      itemName: json['item_name'] ?? '',
      itemCode: json['item_code'] ?? '',
      imageUrl: json['image_url'] ?? '',
      borrowerName: json['borrower_name'] ?? '',
      reason: json['reason'] ?? '',
    );
  }
}