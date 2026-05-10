import 'dart:io';

import 'package:flutter/material.dart';

class ImagePickerBox extends StatelessWidget {
  final File? image;
  final VoidCallback onTap;

  const ImagePickerBox({super.key, required this.image, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,

      child: Container(
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

        child: image != null
            ? ClipRRect(
                borderRadius: BorderRadius.circular(14),

                child: Image.file(
                  File(image!.path),
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
              )
            : Column(
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
                    style: TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                ],
              ),
      ),
    );
  }
}
