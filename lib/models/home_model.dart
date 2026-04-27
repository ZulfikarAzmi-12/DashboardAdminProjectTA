class SummaryModel {
  final int totalItem;
  final int borrowedItem;
  final int damagedItem;

  SummaryModel({
    required this.totalItem,
    required this.borrowedItem,
    required this.damagedItem,
  });

  factory SummaryModel.fromJson(Map<String, dynamic> json) {
    return SummaryModel(
      totalItem: json['totalItem'] ?? 0,
      borrowedItem: json['borrowedItem'] ?? 0,
      damagedItem: json['damagedItem'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'totalItem': totalItem,
      'borrowedItem': borrowedItem,
      'damagedItem': damagedItem,
    };
  }
}
