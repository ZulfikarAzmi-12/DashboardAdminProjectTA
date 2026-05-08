import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomSelector extends StatelessWidget {
  final RxString selectedValue;
  final List<String> options;
  final String hint;

  const CustomSelector({
    super.key,
    required this.selectedValue,
    required this.options,
    required this.hint,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.bottomSheet(
          Container(
            padding: const EdgeInsets.all(16),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(16),
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: options.map((e) => _item(e)).toList(),
            ),
          ),
        );
      },
      child: Obx(
        () => Container(
          margin: const EdgeInsets.only(bottom: 14),
          padding: const EdgeInsets.symmetric(horizontal: 16),
          height: 52,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                blurRadius: 6,
                color: Colors.black.withOpacity(0.05),
                offset: const Offset(0, 2),
              )
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                selectedValue.value.isEmpty
                    ? hint
                    : selectedValue.value,
                style: TextStyle(
                  fontSize: 14,
                  color: selectedValue.value.isEmpty
                      ? Colors.grey
                      : Colors.black,
                ),
              ),
              const Icon(Icons.keyboard_arrow_down, size: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _item(String value) {
    return ListTile(
      title: Text(value),
      onTap: () {
        selectedValue.value = value;
        Get.back();
      },
    );
  }
}