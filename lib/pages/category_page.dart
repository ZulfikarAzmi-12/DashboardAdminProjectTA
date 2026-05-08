import 'package:admin_dashboard/components/appbar/appbar.dart';
import 'package:admin_dashboard/components/button/big_button.dart';
import 'package:admin_dashboard/components/button/slide_action_button.dart';
import 'package:admin_dashboard/components/card/slide_card.dart';
import 'package:admin_dashboard/components/textfield/form_textfield.dart';

import 'package:admin_dashboard/controller/category_controller.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CategoryPage extends StatelessWidget {
  CategoryPage({super.key});

  final controller = Get.find<CategoryController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF5F5F5),

      appBar: CustomAppBar(
        title: "Category",

        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),

          onPressed: () => Get.back(),
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),

        child: Column(
          children: [
            /// TEXTFIELD
            FormTextField(
              controller: controller.categoryTextController,

              hint: "Nama Category",
            ),

            /// BUTTON
            BigButton(title: "Tambah", onTap: () {}),

            const SizedBox(height: 24),

            /// LIST
            Expanded(
              child: Obx(
                () => ListView.builder(
                  itemCount: controller.categoryList.length,

                  itemBuilder: (context, index) {
                    final item = controller.categoryList[index];

                    return SlideCard(
                      title: item.name,

                      actions: [
                        /// EDIT BUTTON
                        SlideActionButton(
                          backgroundColor: const Color(0xffF97316),

                          onTap: () {},

                          child: const Icon(
                            Icons.edit_outlined,

                            color: Colors.white,

                            size: 24,
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
