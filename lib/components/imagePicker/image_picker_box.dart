import 'package:flutter/material.dart';

class ImagePickerBox extends StatelessWidget {
  const ImagePickerBox({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 190,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            blurRadius: 6,
            color: Colors.black.withOpacity(0.05),
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [

          Icon(
            Icons.add_photo_alternate_outlined,
            size: 42,
            color: Colors.grey.shade500,
          ),

          const SizedBox(height: 10),

          Text(
            "Foto Barang",
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}