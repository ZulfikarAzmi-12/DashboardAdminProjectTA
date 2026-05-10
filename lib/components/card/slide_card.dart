import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class SlideCard extends StatelessWidget {
  final String title;

  final bool isActive;

  final List<Widget> actions;

  const SlideCard({
    super.key,
    required this.title,
    required this.actions,
    this.isActive = true,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 18),

      child: Slidable(
        key: ValueKey(title),

        endActionPane: ActionPane(
          motion: const StretchMotion(),
          extentRatio: 0.46,
          children: actions,
        ),

        child: Container(
          width: double.infinity,

          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 26),

          decoration: BoxDecoration(
            color: isActive ? Colors.white : Colors.grey.shade300,

            borderRadius: BorderRadius.circular(20),

            boxShadow: [
              BoxShadow(
                blurRadius: 10,
                color: Colors.black.withOpacity(0.04),

                offset: const Offset(0, 4),
              ),
            ],
          ),

          child: Text(
            title,

            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,

              color: isActive ? Colors.black : Colors.grey.shade700,
            ),
          ),
        ),
      ),
    );
  }
}
