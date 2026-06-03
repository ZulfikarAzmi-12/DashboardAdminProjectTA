import 'package:admin_dashboard/constants/app_color.dart';
import 'package:flutter/material.dart';

class LoanDetailCard extends StatelessWidget {
  final String itemName;
  final String itemCode;
  final String? imageUrl;

  const LoanDetailCard({
    super.key,
    required this.itemName,
    required this.itemCode,
    this.imageUrl,
  });

  Widget get _placeholder =>
      const Icon(Icons.image_outlined, color: AppColor.lightgray, size: 34);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColor.background,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 82,
            height: 82,
            decoration: BoxDecoration(
              color: AppColor.background,
              borderRadius: BorderRadius.circular(10),
            ),
            child: (imageUrl == null || imageUrl!.isEmpty)
                ? _placeholder
                : ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(
                      imageUrl!,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) =>
                          _placeholder,
                    ),
                  ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  itemName,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: AppColor.primary,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  itemCode,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: AppColor.primary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
