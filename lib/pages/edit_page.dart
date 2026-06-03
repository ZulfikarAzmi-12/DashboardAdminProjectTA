import 'package:admin_dashboard/components/appbar/appbar.dart';
import 'package:admin_dashboard/components/button/big_button.dart';
import 'package:admin_dashboard/components/imagePicker/image_picker_box.dart';
import 'package:admin_dashboard/components/textfield/adduser.dart';
import 'package:admin_dashboard/components/textfield/selector_textfield.dart';
import 'package:admin_dashboard/controller/edit_controller.dart';
import 'package:admin_dashboard/models/inventaris_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditPage extends StatelessWidget {
  EditPage({super.key});

  final controller = Get.find<EditController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF5F5F5),
      appBar: CustomAppBar(
        title: "Edit barang",
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Get.back(),
        ),
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              /// NAMA
              AdduserTextField(
                hint: "Nama Barang",
                controller: controller.namaController,
              ),

              /// DESKRIPSI
              AdduserTextField(
                hint: "Description...",
                controller: controller.descController,
              ),

              /// CATEGORY
              CustomSelector<CategoryModel>(
                selectedValue: controller.selectedCategory,
                options: controller.categoryList,
                hint: "Category",

                labelBuilder: (item) => item.categoryName,
                valueBuilder: (item) => item.id,
              ),

              /// LOCATION
              CustomSelector<LocationModel>(
                selectedValue: controller.selectedLocation,
                options: controller.locationList,
                hint: "Location",

                labelBuilder: (item) => item.locationName,
                valueBuilder: (item) => item.id,
              ),

              const SizedBox(height: 6),

              /// IMAGE
              Obx(
                () => ImagePickerBox(
                  image: controller.selectedImage.value,

                  onTap: () {
                    controller.pickImage();
                  },
                ),
              ),

              const SizedBox(height: 24),

              /// BUTTON
              Obx(
                () => BigButton(
                  title: controller.isLoadingUpdate.value
                      ? "Loading..."
                      : "Update Barang",
                  onTap: () {
                    controller.updateItem();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
