import 'package:admin_dashboard/constants/app_color.dart';
import 'package:flutter/material.dart';

class InventarisChip extends StatelessWidget {
  final String title;
  final bool isSelected;
  final VoidCallback onTap;

  const InventarisChip({
    super.key,
    required this.title,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        margin: const EdgeInsets.only(right: 12),
        padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 12),
        decoration: BoxDecoration(
          color: isSelected
              ? AppColor.primary
              : const Color(0xFFF2F2F2), // abu muda seperti gambar
          borderRadius: BorderRadius.circular(40),
          border: Border.all(
            color: AppColor.primary,
            width: 2, // lebih tegas seperti di gambar
          ),
        ),
        child: Text(
          title,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: isSelected ? Colors.white : AppColor.primary,
          ),
        ),
      ),
    );
  }
}
