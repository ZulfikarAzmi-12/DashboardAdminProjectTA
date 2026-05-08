import 'package:flutter/material.dart';
import '../../constants/app_color.dart';

class MenuTile extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback onTap;

  const MenuTile({
    super.key,
    required this.title,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Material(
        color: const Color(0xFFEDEDED), // abu seperti gambar
        borderRadius: BorderRadius.circular(10),
        child: InkWell(
          borderRadius: BorderRadius.circular(10),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 14,
              vertical: 10, // 🔥 lebih kecil (sebelumnya 14)
            ),
            child: Row(
              children: [

                // ICON BOX
                Container(
                  padding: const EdgeInsets.all(6), // 🔥 diperkecil
                  decoration: BoxDecoration(
                    color: AppColor.primary,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Icon(
                    icon,
                    color: Colors.white,
                    size: 16, // 🔥 lebih kecil
                  ),
                ),

                const SizedBox(width: 12),

                // TEXT
                Expanded(
                  child: Text(
                    title,
                    style: const TextStyle(
                      fontSize: 14, // 🔥 lebih kecil
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),

                // ARROW
                const Icon(
                  Icons.arrow_forward_ios,
                  size: 14,
                  color: Colors.black54,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}