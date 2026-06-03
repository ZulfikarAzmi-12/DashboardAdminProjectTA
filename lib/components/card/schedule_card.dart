import 'package:flutter/material.dart';

class ScheduleCard extends StatelessWidget {
  final String borrowedDate;
  final String returnDate;
  final String status;

  const ScheduleCard({
    super.key,
    required this.borrowedDate,
    required this.returnDate,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFFF3F4F6),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "$borrowedDate → $returnDate",
            style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 6),
          Text(
            status,
            style: TextStyle(
              fontSize: 15,
              color: status == "dibooking" ? Colors.orange : Colors.green,
            ),
          ),
        ],
      ),
    );
  }
}
