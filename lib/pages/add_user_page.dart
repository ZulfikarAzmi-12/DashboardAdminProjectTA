import 'package:admin_dashboard/components/appbar/appbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:admin_dashboard/constants/app_color.dart';
import 'package:admin_dashboard/controller/manageuser_controller.dart';
import 'package:admin_dashboard/components/textfield/adduser.dart';
import 'package:admin_dashboard/components/textfield/selector_textfield.dart';
import 'package:admin_dashboard/components/button/big_button.dart';

class AddUserPage extends StatelessWidget {
  AddUserPage({super.key});

  final controller = Get.find<ManageUserController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.background,
      resizeToAvoidBottomInset: true,
      appBar: CustomAppBar(
        title: "Tambahkan User",
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Get.back(),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            /// NAMA
            AdduserTextField(
              hint: "Nama",
              controller: controller.nameController,
            ),

            /// EMAIL
            AdduserTextField(
              hint: "Email",
              controller: controller.emailController,
              keyboardType: TextInputType.emailAddress,
            ),

            /// PHONE
            AdduserTextField(
              hint: "Phone",
              controller: controller.phoneController,
              keyboardType: TextInputType.phone,
            ),

            /// ROLE (CUSTOM SELECTOR)
            CustomSelector<String>(
              selectedValue: controller.selectedRole,
              hint: "Role",
              options: ["admin", "user"],

              labelBuilder: (item) => item,
              valueBuilder: (item) => item,
            ),

            const SizedBox(height: 12),

            /// BUTTON
            BigButton(
              title: "Tambah",
              onTap: () {
                controller.createUser();
              },
            ),
          ],
        ),
      ),
    );
  }
}
