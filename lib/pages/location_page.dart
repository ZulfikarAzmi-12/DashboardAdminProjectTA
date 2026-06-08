import 'package:admin_dashboard/components/appbar/appbar.dart';
import 'package:admin_dashboard/components/button/big_button.dart';
import 'package:admin_dashboard/components/card/slide_card.dart';
import 'package:admin_dashboard/components/button/slide_action_button.dart';
import 'package:admin_dashboard/components/textfield/form_textfield.dart';
import 'package:admin_dashboard/controller/location_controller.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LocationPage extends StatelessWidget {
  LocationPage({super.key});

  final controller = Get.find<LocationController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF5F5F5),

      appBar: CustomAppBar(
        title: "Lokasi",

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
              controller: controller.locationTextController,

              hint: "Nama Lokasi",
            ),

            /// BUTTON
            BigButton(
              title: "Tambah",
              onTap: () {
                controller.createLocation();
              },
            ),

            const SizedBox(height: 24),

            /// LIST
            Expanded(
              child: Obx(
                () => ListView.builder(
                  itemCount: controller.locationList.length,

                  itemBuilder: (context, index) {
                    final item = controller.locationList[index];

                    return SlideCard(
                      title: item.locationName,
                      isActive: item.isActive ?? false, // ✅ hapus negasi !

                      actions: [
                        /// EDIT BUTTON
                        SlideActionButton(
                          backgroundColor: const Color(0xffF97316),
                          onTap: () {
                            showEditLocationDialog(
                              context: context,
                              initialValue: item.locationName,
                              onSave: (value) {
                                controller.updateLocation(
                                  locationId: item.id,
                                  locationName: value,
                                );
                              },
                            );
                          },
                          child: const Icon(
                            Icons.edit_outlined,
                            color: Colors.white,
                            size: 24,
                          ),
                        ),

                        /// ON OFF BUTTON
                        SlideActionButton(
                          // ✅ isActive true  → tampil OFF (merah)
                          // ✅ isActive false → tampil ON  (hijau)
                          backgroundColor: (item.isActive ?? false)
                              ? const Color(0xffEF4444)
                              : const Color(0xff65B741),

                          onTap: () {
                            controller.updateLocation(
                              locationId: item.id,
                              isActive:
                                  !(item.isActive ?? false), // toggle nilai
                            );
                          },

                          child: Text(
                            (item.isActive ?? false)
                                ? "OFF"
                                : "ON", // ✅ sesuai status
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ),
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

  void showEditLocationDialog({
    required BuildContext context,
    required String initialValue,
    required Function(String value) onSave,
  }) {
    final TextEditingController controller = TextEditingController(
      text: initialValue,
    );

    Get.dialog(
      AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),

        title: const Text(
          "Edit Lokasi",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),

        content: TextField(
          controller: controller,

          decoration: InputDecoration(
            hintText: "Nama lokasi",

            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          ),
        ),

        actions: [
          /// CANCEL
          TextButton(
            onPressed: () {
              Get.back();
            },

            child: const Text("Batal"),
          ),

          /// SAVE
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xff2563EB),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),

            onPressed: () {
              onSave(controller.text);

              Get.back();
            },

            child: const Text("Simpan", style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }
}
