import 'package:admin_dashboard/constants/app_color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  /// custom leading (bebas: back, icon, dll)
  final Widget? leading;

  /// actions kanan
  final List<Widget>? actions;

  final Color backgroundColor;
  final Color titleColor;

  const CustomAppBar({
    super.key,
    required this.title,
    this.leading,
    this.actions,
    this.backgroundColor = AppColor.background,
    this.titleColor = AppColor.primary,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: backgroundColor,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 6,
            offset: Offset(0, 4), 
          ),
        ],
      ),
      child: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0, 
        centerTitle: false,
        leading: leading,
        title: Text(
          title,
          style: TextStyle(
            color: titleColor,
            fontWeight: FontWeight.w600,
            fontSize: 18,
          ),
        ),
        actions: actions,
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
