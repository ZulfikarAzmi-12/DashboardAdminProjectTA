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
    required this.onTap
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(right: 8),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? AppColor.primary : Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: AppColor.primary.withOpacity(0.5)),
        ),
        child: Text(
          title,
          style: TextStyle(
            color: isSelected ? Colors.white : AppColor.primary,
          ),
        ),
      ),
    );
  }
}