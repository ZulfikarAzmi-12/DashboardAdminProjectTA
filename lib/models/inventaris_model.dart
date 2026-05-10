class InventoryModel {
  final String id;
  final String itemCode;
  final String name;
  final String description;
  final bool isAvalible;
  final int avalibleUnit;
  final CategoryModel category;
  final LocationModel location;
  final ImageModel image;

  InventoryModel({
    required this.id,
    required this.itemCode,
    required this.name,
    required this.description,
    required this.isAvalible,
    required this.avalibleUnit,
    required this.category,
    required this.location,
    required this.image,
  });

  factory InventoryModel.fromJson(Map<String, dynamic> json) {
    return InventoryModel(
      id: json['id'],
      itemCode: json['itemCode'],
      name: json['name'],
      description: json['description'],
      isAvalible: json['isAvalible'],
      avalibleUnit: json['avalibleUnit'],
      category: CategoryModel.fromJson(json['category']),
      location: LocationModel.fromJson(json['location']),
      image: ImageModel.fromJson(json['image']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'itemCode': itemCode,
      'name': name,
      'description': description,
      'isAvalible': isAvalible,
      'avalibleUnit': avalibleUnit,
      'category': category.toJson(),
      'location': location.toJson(),
      'image': image.toJson(),
    };
  }
}

class CategoryModel {
  final String id;
  final String categoryName;

  CategoryModel({required this.id, required this.categoryName});

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(id: json['id'], categoryName: json['categoryName']);
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'categoryName': categoryName};
  }
}

class LocationModel {
  final String id;
  final String locationName;
  bool? isActive;

  LocationModel({required this.id, required this.locationName, this.isActive});

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

class ImageModel {
  final String imageUrl;

  ImageModel({required this.imageUrl});

  factory ImageModel.fromJson(Map<String, dynamic> json) {
    return ImageModel(imageUrl: json['imageUrl']);
  }

  Map<String, dynamic> toJson() {
    return {'imageUrl': imageUrl};
  }
}
