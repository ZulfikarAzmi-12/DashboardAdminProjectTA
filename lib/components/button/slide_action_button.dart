import 'package:flutter/material.dart';

class SlideActionButton
    extends StatelessWidget {

  final Color backgroundColor;

  final Widget child;

  final VoidCallback? onTap;

  const SlideActionButton({
    super.key,
    required this.backgroundColor,
    required this.child,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 14),

      child: GestureDetector(
        onTap: onTap,

        child: Container(
          width: 58,
          height: 58,

          decoration: BoxDecoration(
            color: backgroundColor,

            borderRadius:
                BorderRadius.circular(14),

            boxShadow: [
              BoxShadow(
                blurRadius: 8,
                color:
                    Colors.black.withOpacity(0.08),

                offset: const Offset(0, 3),
              ),
            ],
          ),

          child: Center(
            child: child,
          ),
        ),
      ),
    );
  }
}