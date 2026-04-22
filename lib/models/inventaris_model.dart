import 'package:flutter/material.dart';
import 'package:get/get.dart';

// ================= MODEL =================

class InventarisModel {
  final String name;
  final int stock;
  final String location;
  final String category;
  final String image;

  InventarisModel({
    required this.name,
    required this.stock,
    required this.location,
    required this.category,
    required this.image,
  });

  factory InventarisModel.fromJson(Map<String, dynamic> json) {
    return InventarisModel(
      name: json['name'] ?? '',
      stock: json['stock'] ?? 0,
      location: json['location'] ?? '',
      category: json['category'] ?? '',
      image: json['image'] ?? '',
    );
  }
}
