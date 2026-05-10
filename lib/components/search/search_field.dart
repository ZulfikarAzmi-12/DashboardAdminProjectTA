import 'package:admin_dashboard/constants/app_color.dart';
import 'package:flutter/material.dart';

class SearchField extends StatelessWidget {
  final Function(String)? onChanged;

  const SearchField({super.key, this.onChanged});

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
        children: [
          Expanded(
            child: TextField(
              onChanged: onChanged,
              decoration: const InputDecoration(
                hintText: "Cari barang...",
                border: InputBorder.none,
              ),
            ),
          ),
          const Icon(Icons.search, color: AppColor.primary),
        ],
      ),
    );
  }
}
