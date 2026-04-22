import 'package:admin_dashboard/constants/app_color.dart';
import 'package:flutter/material.dart';

class SearchField extends StatelessWidget {
  const SearchField({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColor.primary.withOpacity(0.3)),
      ),
      child: Row(
        children: const [
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                hintText: "Cari barang...",
                border: InputBorder.none,
              ),
            ),
          ),
          Icon(Icons.search, color: AppColor.primary),
        ],
      ),
    );
  }
}