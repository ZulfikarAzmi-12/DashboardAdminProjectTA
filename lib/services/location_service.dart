import 'package:admin_dashboard/models/location_model.dart';

class LocationService {

  Future<List<LocationModel>>
      getLocations() async {

    await Future.delayed(
      const Duration(milliseconds: 500),
    );

    return [

      LocationModel(
        id: 1,
        name: "Gudang A",
        isActive: true,
      ),

      LocationModel(
        id: 2,
        name: "Gudang Alat",
        isActive: false,
      ),

      LocationModel(
        id: 3,
        name: "Ruang Fotografi",
        isActive: true,
      ),
    ];
  }
}