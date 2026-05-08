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

  final controller =
      Get.find<LocationController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          const Color(0xffF5F5F5),

      appBar: CustomAppBar(
        title: "Lokasi",

        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),

          onPressed: () => Get.back(),
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),

        child: Column(
          children: [

            /// TEXTFIELD
            FormTextField(
              controller:
                  controller
                      .locationTextController,

              hint: "Nama Lokasi",
            ),

            /// BUTTON
            BigButton(
              title: "Tambah",
              onTap: () {},
            ),

            const SizedBox(height: 24),

            /// LIST
            Expanded(
              child: Obx(
                () => ListView.builder(
                  itemCount:
                      controller
                          .locationList
                          .length,

                  itemBuilder:
                      (context, index) {

                    final item =
                        controller
                            .locationList[index];

                    return SlideCard(
                      title: item.name,

                      actions: [

                        /// EDIT BUTTON
                        SlideActionButton(
                          backgroundColor:
                              const Color(
                                0xffF97316,
                              ),

                          onTap: () {},

                          child: const Icon(
                            Icons
                                .edit_outlined,

                            color:
                                Colors.white,

                            size: 24,
                          ),
                        ),

                        /// ON OFF BUTTON
                        SlideActionButton(
                          backgroundColor:
                              item.isActive
                                  ? const Color(
                                      0xff65B741,
                                    )
                                  : const Color(
                                      0xffEF4444,
                                    ),

                          onTap: () {
                            controller
                                .toggleLocationStatus(
                                  index,
                                );
                          },

                          child: Text(
                            item.isActive
                                ? "ON"
                                : "OFF",

                            style:
                                const TextStyle(
                                  color:
                                      Colors.white,

                                  fontWeight:
                                      FontWeight
                                          .bold,

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
}