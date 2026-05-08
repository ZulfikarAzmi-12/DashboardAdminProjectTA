import 'package:admin_dashboard/models/inventaris_model.dart';
import 'package:flutter/material.dart';

class InventarisService {
  Future<List<InventarisModel>> fetchItems() async {
    await Future.delayed(const Duration(seconds: 1));

    final response = {
      "success": true,
      "data": List.generate(
        6,
        (index) => {
          "name": "Camera canon g7x m5",
          "stock": 5,
          "location": "Gudang A",
          "category": "Fotografi",
          "image": "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSSBVIfC_KX-xaAzdYRpP_4agrjnSZezBju7g&s",
        },
      )
    };

    final data = response['data'] as List;
    return data.map((e) => InventarisModel.fromJson(e)).toList();
  }
}