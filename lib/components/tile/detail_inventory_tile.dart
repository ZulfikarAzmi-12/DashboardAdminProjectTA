import 'package:admin_dashboard/models/detail_inventory_model.dart';
import 'package:flutter/material.dart';

class DetailInventoryTile extends StatelessWidget {
  final UnitModel unit;

  const DetailInventoryTile({super.key, required this.unit});

  Color _getStatusColor() {
    switch (unit.status.toLowerCase()) {
      case 'tersedia':
        return Colors.green;
      case 'perbaikan':
        return Colors.orange;
      default:
        return Colors.redAccent;
    }
  }

  IconData _getStatusIcon() {
    switch (unit.status.toLowerCase()) {
      case 'tersedia':
        return Icons.check_circle_outline;
      case 'perbaikan':
        return Icons.build_outlined;
      default:
        return Icons.cancel_outlined;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(bottom: BorderSide(color: Color(0xFFF0F0F0), width: 1)),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(9),
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(
              Icons.devices_outlined,
              size: 20,
              color: Color(0xFF5C6BC0),
            ),
          ),

          const SizedBox(width: 14),

          // ── Unit code ─────────────────────────────────────────────────
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  unit.itemUnitCode,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                    color: Color(0xFF1A1A2E),
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  'ID: ${unit.id}',
                  style: TextStyle(fontSize: 11, color: Colors.grey.shade500),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),

          const SizedBox(width: 10),

          // ── Status chip ───────────────────────────────────────────────
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: BoxDecoration(
              color: _getStatusColor().withOpacity(0.12),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: _getStatusColor().withOpacity(0.4),
                width: 1,
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(_getStatusIcon(), size: 12, color: _getStatusColor()),
                const SizedBox(width: 4),
                Text(
                  unit.status,
                  style: TextStyle(
                    color: _getStatusColor(),
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),

          // ── Arrow ─────────────────────────────────────────────────────
          const SizedBox(width: 8),
          Icon(Icons.chevron_right, size: 18, color: Colors.grey.shade400),
        ],
      ),
    );
  }
}
