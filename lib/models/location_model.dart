class LocationModel {
  final String id;
  final String locationName;
  final bool isActive;

  LocationModel({
    required this.id,
    required this.locationName,
    required this.isActive,
  });

  factory LocationModel.fromJson(Map<String, dynamic> json) {
    return LocationModel(
      id: json['id'] ?? '',
      locationName: json['locationName'] ?? '',
      isActive: json['isActive'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {"id": id, "locationName": locationName, "isActive": isActive};
  }
}
