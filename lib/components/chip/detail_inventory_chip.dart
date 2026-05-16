import 'package:flutter/material.dart';

class DetailInventoryChip extends StatelessWidget {
  final String title;
  final IconData? icon;

  const DetailInventoryChip({
    super.key,
    required this.title,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 6,
      ),
      decoration: BoxDecoration(
        color: const Color(0xff922B21),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [

          if (icon != null) ...[
            Icon(
              icon,
              size: 14,
              color: Colors.white,
            ),

            const SizedBox(width: 4),
          ],

          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}