class CategoryModel {
  final String id;
  final String categoryName;

  CategoryModel({required this.id, required this.categoryName});

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: json['id'] ?? '',
      categoryName: json['categoryName'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {"id": id, "categoryName": categoryName};
  }
}
