import 'package:admin_dashboard/components/button/home_button.dart';
import 'package:admin_dashboard/components/card/loan_card.dart';
import 'package:admin_dashboard/components/card/summary_card.dart';
import 'package:admin_dashboard/constants/app_color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/home_controller.dart';

class HomePage extends StatelessWidget {
  final controller = Get.find<HomeController>();

  HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.background,

      body: SafeArea(
        child: Obx(() {
          if (controller.isLoading.value) {
            return Center(child: CircularProgressIndicator());
          }

          if (controller.isError.value) {
            return Center(child: Text("Terjadi kesalahan"));
          }

          return SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Ringkasan",
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: AppColor.blacktext,
                    ),
                  ),
                  SizedBox(height: 16),

                  Wrap(
                    spacing: 12,
                    runSpacing: 12,
                    children: [
                      SizedBox(
                        width: (MediaQuery.of(context).size.width - 44) / 2,
                        child: SummaryCard(
                          title: "Total Barang",
                          value:
                              "${controller.summary.value?.totalItem ?? "0"}",
                        ),
                      ),

                      SizedBox(
                        width: (MediaQuery.of(context).size.width - 44) / 2,
                        child: SummaryCard(
                          title: "Dipinjam",
                          value:
                              "${controller.summary.value?.borrowedItem ?? "0"}",
                        ),
                      ),

                      SizedBox(
                        width: (MediaQuery.of(context).size.width - 32) / 2,
                        child: SummaryCard(
                          title: "Barang Rusak",
                          value:
                              "${controller.summary.value?.damagedItem ?? "0"}",
                        ),
                      ),
                    ],
                  ),

                  Container(
                    margin: EdgeInsets.only(top: 15),
                    child: Row(
                      children: [
                        Expanded(
                          child: HomeButton(
                            text: "Tambah Barang",
                            icon: Icons.add,
                            onPressed: () {},
                          ),
                        ),
                        Expanded(
                          child: Container(
                            margin: EdgeInsets.only(left: 12),
                            child: HomeButton(
                              text: "Pinjam Barang",
                              icon: Icons.inventory_2_outlined,
                              onPressed: () {},
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Peminjaman",
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            color: AppColor.blacktext,
                          ),
                        ),

                        InkWell(
                          onTap: () {
                            Get.toNamed("/all-loans");
                          },
                          child: Row(
                            children: [
                              Text(
                                "Lihat Semua",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: AppColor.primary,
                                ),
                              ),
                              SizedBox(width: 5),
                              Icon(
                                Icons.arrow_forward_ios,
                                size: 14,
                                color: AppColor.primary,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (controller.loans.isEmpty)
                    Container(
                      margin: EdgeInsets.only(top: 20),
                      alignment: Alignment.center,
                      child: Text("Belum ada data"),
                    )
                  else
                    ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: controller.loans.length,
                      itemBuilder: (context, index) {
                        final loan = controller.loans[index];

                        return LoanCard(data: loan);
                      },
                    ),

                  SizedBox(height: 20),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}
