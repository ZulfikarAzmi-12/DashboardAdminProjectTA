import 'package:admin_dashboard/models/inventaris_model.dart';
import 'package:admin_dashboard/services/inventaris_service.dart';
import 'package:get/get.dart';

class InventarisController extends GetxController {
  final InventarisService service = InventarisService();

  var items = <InventarisModel>[].obs;
  var selectedCategory = "All".obs;
  var searchQuery = "".obs; // 🔥 tambahan
  var isLoading = false.obs;

  @override
  void onInit() {
    fetchItems();
    super.onInit();
  }

  void fetchItems() async {
    try {
      isLoading.value = true;
      final data = await service.fetchItems();
      items.value = data;
    } catch (e) {
      // 🔥 nanti bisa kamu ganti snackbar / logger
      print("Error fetch items: $e");
    } finally {
      isLoading.value = false;
    }
  }

  // 🔥 COMBINED FILTER (category + search)
  List<InventarisModel> get filteredItems {
    var result = items;

    // FILTER CATEGORY
    if (selectedCategory.value != "All") {
      result = result
          .where((e) => e.category == selectedCategory.value)
          .toList()
          .obs;
    }

    // FILTER SEARCH
    if (searchQuery.value.isNotEmpty) {
      result = result
          .where((e) => e.name
              .toLowerCase()
              .contains(searchQuery.value.toLowerCase()))
          .toList()
          .obs;
    }

    return result;
  }

  // 🔥 helper untuk update search
  void updateSearch(String value) {
    searchQuery.value = value;
  }
}