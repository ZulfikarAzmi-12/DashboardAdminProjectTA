import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomSelector<T> extends StatelessWidget {
  final RxString selectedValue;
  final List<T> options;
  final String hint;

  final String Function(T item) labelBuilder;
  final String Function(T item) valueBuilder;

  const CustomSelector({
    super.key,
    required this.selectedValue,
    required this.options,
    required this.hint,
    required this.labelBuilder,
    required this.valueBuilder,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
        ),

        child: DropdownButton<String>(
          value: selectedValue.value.isEmpty ? null : selectedValue.value,

          isExpanded: true,
          underline: const SizedBox(),

          hint: Text(
            hint,
            style: const TextStyle(color: Colors.grey, fontSize: 16),
          ),

          items: options.map((item) {
            return DropdownMenuItem<String>(
              value: valueBuilder(item),
              child: Text(labelBuilder(item)),
            );
          }).toList(),

          onChanged: (value) {
            if (value != null) {
              selectedValue.value = value;
            }
          },
        ),
      ),
    );
  }
}
