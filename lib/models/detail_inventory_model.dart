// lib/models/item_detail_model.dart

class ItemDetailModel {
  final String id;
  final String itemCode;
  final String name;
  final String description;
  final DetailLocationModel location;
  final DetailCategoryModel category;
  final ImageModel image;
  final bool isAvailable;
  final int totalUnit;
  final List<UnitModel> unit;

  ItemDetailModel({
    required this.id,
    required this.itemCode,
    required this.name,
    required this.description,
    required this.location,
    required this.category,
    required this.image,
    required this.isAvailable,
    required this.totalUnit,
    required this.unit,
  });

  factory ItemDetailModel.fromJson(Map<String, dynamic> json) {
    return ItemDetailModel(
      id: json['id'] as String,
      itemCode: json['itemCode'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      location: DetailLocationModel.fromJson(
        json['location'] as Map<String, dynamic>,
      ),
      category: DetailCategoryModel.fromJson(
        json['category'] as Map<String, dynamic>,
      ),
      image: ImageModel.fromJson(json['image'] as Map<String, dynamic>),
      isAvailable: json['isAvalible'] as bool,
      totalUnit: json['totalUnit'] as int,
      unit: (json['unit'] as List<dynamic>)
          .map((e) => UnitModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'itemCode': itemCode,
    'name': name,
    'description': description,
    'location': location.toJson(),
    'category': category.toJson(),
    'image': image.toJson(),
    'isAvalible': isAvailable,
    'totalUnit': totalUnit,
    'unit': unit.map((e) => e.toJson()).toList(),
  };
}

// ── Location ───────────────────────────────────────────────────────────────

class DetailLocationModel {
  final String id;
  final String locationName;

  DetailLocationModel({required this.id, required this.locationName});

  factory DetailLocationModel.fromJson(Map<String, dynamic> json) {
    return DetailLocationModel(
      id: json['id'] as String,
      locationName: json['locationName'] as String,
    );
  }

  Map<String, dynamic> toJson() => {'id': id, 'locationName': locationName};
}

// ── Category ───────────────────────────────────────────────────────────────

class DetailCategoryModel {
  final String id;
  final String categoryName;

  DetailCategoryModel({required this.id, required this.categoryName});

  factory DetailCategoryModel.fromJson(Map<String, dynamic> json) {
    return DetailCategoryModel(
      id: json['id'] as String,
      categoryName: json['categoryName'] as String,
    );
  }

  Map<String, dynamic> toJson() => {'id': id, 'categoryName': categoryName};
}

// ── Image ──────────────────────────────────────────────────────────────────

class ImageModel {
  final String imageUrl;

  ImageModel({required this.imageUrl});

  factory ImageModel.fromJson(Map<String, dynamic> json) {
    return ImageModel(imageUrl: json['imageUrl'] as String);
  }

  Map<String, dynamic> toJson() => {'imageUrl': imageUrl};
}

// ── Unit ───────────────────────────────────────────────────────────────────

class UnitModel {
  final String id;
  final String itemUnitCode;
  final String status;

  UnitModel({
    required this.id,
    required this.itemUnitCode,
    required this.status,
  });

  factory UnitModel.fromJson(Map<String, dynamic> json) {
    return UnitModel(
      id: json['id'] as String,
      itemUnitCode: json['itemUnitCode'] as String,
      status: json['status'] as String,
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'itemUnitCode': itemUnitCode,
    'status': status,
  };
}
