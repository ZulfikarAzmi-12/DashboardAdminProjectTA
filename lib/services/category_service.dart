import '../models/category_model.dart';

class CategoryService {

  Future<List<CategoryModel>>
      getCategories() async {

    await Future.delayed(
      const Duration(milliseconds: 500),
    );

    return [

      CategoryModel(
        id: 1,
        name: "Elektronik",
      ),

      CategoryModel(
        id: 2,
        name: "Fotografi",
      ),

      CategoryModel(
        id: 3,
        name: "Mesin",
      ),
    ];
  }
}