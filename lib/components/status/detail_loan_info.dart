import 'package:admin_dashboard/constants/app_color.dart';
import 'package:flutter/material.dart';

class DetailLoanInfo extends StatelessWidget {
  final String title;
  final String value;
  final IconData? icon;
  final bool isColumn;

  const DetailLoanInfo({
    super.key,
    required this.title,
    required this.value,
    this.icon,
    this.isColumn = false,
  });

  /// "15 Mei 2026, 08.00" → ["15 Mei 2026", "08.00"]
  /// Kalau tidak ada koma → null (render value biasa seperti semula)
  List<String>? _splitDateTime() {
    if (!value.contains(',')) return null;
    final parts = value.split(',');
    if (parts.length < 2) return null;
    return [parts[0].trim(), parts[1].trim()];
  }

  @override
  Widget build(BuildContext context) {
    final dateTime = _splitDateTime();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ── Title ──────────────────────────────────────────────────────
        Text(
          title,
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w600,
            color: AppColor.blacktext,
          ),
        ),

        const SizedBox(height: 8),

        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Optional icon ───────────────────────────────────────────
            if (icon != null) ...[
              const Icon(
                Icons.arrow_downward,
                color: AppColor.primary,
                size: 20,
              ),
              const SizedBox(width: 2),
              Icon(icon, color: AppColor.primary, size: 20),
              const SizedBox(width: 8),
            ],

            Expanded(
              child: dateTime != null
                  // ── Tanggal & Jam dipisah vertikal ─────────────────────
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Tanggal
                        Text(
                          dateTime[0],
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: AppColor.blacktext,
                          ),
                        ),
                        const SizedBox(height: 4),
                        // Jam
                        Text(
                          dateTime[1],
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: AppColor.blacktext,
                          ),
                        ),
                      ],
                    )
                  // ── Value biasa (tidak ada koma) ───────────────────────
                  : Text(
                      value,
                      style: TextStyle(
                        fontSize: isColumn ? 16 : 15,
                        fontWeight: isColumn
                            ? FontWeight.w500
                            : FontWeight.w600,
                        color: AppColor.blacktext,
                        height: 1.5,
                      ),
                    ),
            ),
          ],
        ),
      ],
    );
  }
}
