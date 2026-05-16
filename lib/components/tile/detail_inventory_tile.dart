import 'package:flutter/material.dart';

class DetailInventoryTile extends StatelessWidget {
  final String id;
  final String status;

  const DetailInventoryTile({
    super.key,
    required this.id,
    required this.status,
  });

  Color getStatusColor() {

    switch (status) {

      case 'Tersedia':
        return Colors.green;

      case 'Dipinjam':
        return Colors.blue;

      default:
        return Colors.orange;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [

          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(
              Icons.sell_outlined,
              size: 18,
              color: Colors.redAccent,
            ),
          ),

          const SizedBox(width: 12),

          Expanded(
            child: Text(
              id,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
              ),
            ),
          ),

          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 5,
            ),
            decoration: BoxDecoration(
              color: getStatusColor(),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              status,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 11,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}