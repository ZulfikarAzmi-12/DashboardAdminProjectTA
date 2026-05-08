class LocationModel {
  final int id;
  final String name;
  bool isActive;

  LocationModel({
    required this.id,
    required this.name,
    required this.isActive,
  });

  factory LocationModel.fromJson(
    Map<String, dynamic> json,
  ) {
    return LocationModel(
      id: json['id'],
      name: json['name'],
      isActive: json['is_active'],
    );
  }
}