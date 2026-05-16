import 'package:admin_dashboard/models/detail_inventory_model.dart';
import 'package:get/get.dart';


class DetailInventoryController extends GetxController {

  late DetailInventoryModel inventory;

  @override
  void onInit() {
    super.onInit();

    loadDummyData();
  }

  void loadDummyData() {

    inventory = DetailInventoryModel(
      image:
          'https://images.unsplash.com/photo-1523381210434-271e8be1f52b',
      title: 'Camera canon g7x m5',
      inventoryId: 'SCH-ELC-001',
      totalUnit: 2,
      location: 'Gudang A',
      category: 'Fotografi',
      description:
          'Lorem Ipsum is simply dummy text of the printing and typesetting industry.',
      units: [
        {
          'id': 'SCH-ELC-001-1',
          'status': 'Tersedia',
        },
        {
          'id': 'SCH-ELC-001-2',
          'status': 'Dipinjam',
        },
        {
          'id': 'SCH-ELC-001-3',
          'status': 'Perbaikan',
        },
      ],
    );
  }

  void onDeactivate() {

    // action deactivate
  }

  void onEdit() {

    // navigate edit page
  }
}