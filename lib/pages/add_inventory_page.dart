import 'package:admin_dashboard/components/appbar/appbar.dart';
import 'package:admin_dashboard/components/button/big_button.dart';
import 'package:admin_dashboard/components/imagePicker/image_picker_box.dart';
import 'package:admin_dashboard/components/textfield/adduser.dart';
import 'package:admin_dashboard/components/textfield/selector_textfield.dart';
import 'package:admin_dashboard/controller/add_inventory_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddInventoryPage extends StatelessWidget {
  AddInventoryPage({super.key});

  final controller = Get.find<AddInventoryController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF5F5F5),
      appBar: CustomAppBar(
        title: "Tambahkan Barang",
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
              CustomSelector(
                selectedValue: controller.selectedCategory,
                options: controller.categoryList,
                hint: "Category",
              ),

              /// LOCATION
              CustomSelector(
                selectedValue: controller.selectedLocation,
                options: controller.locationList,
                hint: "Location",
              ),

              /// JUMLAH
              AdduserTextField(
                hint: "Jumlah Unit",
                controller: controller.jumlahController,
                keyboardType: TextInputType.number,
              ),

              const SizedBox(height: 6),

              /// IMAGE
              const ImagePickerBox(),

              const SizedBox(height: 24),

              /// BUTTON
              BigButton(
                title: "Tambah",
                onTap: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}