import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateTimePickerField extends StatelessWidget {
  final String hint;

  final DateTime? selectedDate;

  final ValueChanged<DateTime> onDateSelected;

  const DateTimePickerField({
    super.key,
    required this.hint,
    required this.selectedDate,
    required this.onDateSelected,
  });

  String get _displayText {
    if (selectedDate == null) {
      return hint;
    }

    return DateFormat('dd MMM yyyy, HH:mm').format(selectedDate!);
  }

  Future<void> _pickDateTime(BuildContext context) async {
    final now = DateTime.now();

    // pilih tanggal
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? now,
      firstDate: now,
      lastDate: DateTime(now.year + 5),
    );

    if (pickedDate == null) return;

    // pilih jam
    final pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(selectedDate ?? now),
      builder: (context, child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
          child: child!,
        );
      },
    );

    if (pickedTime == null) return;

    final finalDateTime = DateTime(
      pickedDate.year,
      pickedDate.month,
      pickedDate.day,
      pickedTime.hour,
      pickedTime.minute,
    );

    onDateSelected(finalDateTime);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _pickDateTime(context),

      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),

        decoration: BoxDecoration(
          color: const Color(0xFFF3F4F6),

          borderRadius: BorderRadius.circular(10),
        ),

        child: Row(
          children: [
            const Icon(Icons.access_time, size: 20, color: Color(0xFF9B1C1C)),

            const SizedBox(width: 12),

            Text(
              _displayText,
              style: TextStyle(
                fontSize: 14,
                color: selectedDate == null
                    ? const Color(0xFF9CA3AF)
                    : const Color(0xFF111827),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
