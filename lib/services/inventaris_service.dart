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
          "image": "https://via.placeholder.com/150",
        },
      )
    };

    final data = response['data'] as List;
    return data.map((e) => InventarisModel.fromJson(e)).toList();
  }
}