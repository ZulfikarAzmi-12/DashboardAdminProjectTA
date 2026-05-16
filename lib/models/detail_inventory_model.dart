class DetailInventoryModel {
  final String image;
  final String title;
  final String inventoryId;
  final int totalUnit;
  final String location;
  final String category;
  final String description;

  final List<Map<String, dynamic>> units;

  DetailInventoryModel({
    required this.image,
    required this.title,
    required this.inventoryId,
    required this.totalUnit,
    required this.location,
    required this.category,
    required this.description,
    required this.units,
  });

  factory DetailInventoryModel.fromJson(
    Map<String, dynamic> json,
  ) {
    return DetailInventoryModel(
      image: json['image'] ?? '',
      title: json['title'] ?? '',
      inventoryId: json['inventory_id'] ?? '',
      totalUnit: json['total_unit'] ?? 0,
      location: json['location'] ?? '',
      category: json['category'] ?? '',
      description: json['description'] ?? '',
      units: List<Map<String, dynamic>>.from(
        json['units'] ?? [],
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'image': image,
      'title': title,
      'inventory_id': inventoryId,
      'total_unit': totalUnit,
      'location': location,
      'category': category,
      'description': description,
      'units': units,
    };
  }
}