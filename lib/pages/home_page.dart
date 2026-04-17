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
          /// LOADING
          if (controller.isLoading.value) {
            return Center(child: CircularProgressIndicator());
          }

          /// ERROR
          if (controller.isError.value) {
            return Center(child: Text("Terjadi kesalahan"));
          }

          /// CONTENT
          return SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  /// 🔥 HEADER
                  Text(
                    "Ringkasan",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: AppColor.primary,
                    ),
                  ),

                  /// 🔥 SUMMARY ROW 1
                  Container(
                    margin: EdgeInsets.only(top: 12),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: SummaryCard(
                            title: "Total Barang",
                            value: "350",
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Container(
                            margin: EdgeInsets.only(left: 12),
                            child: SummaryCard(
                              title: "Dipinjam",
                              value: "10",
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  /// 🔥 SUMMARY ROW 2
                  Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: Container(
                          margin: EdgeInsets.only(top: 12),
                          child: SummaryCard(
                            title: "Barang Rusak",
                            value: "5",
                          ),
                        ),
                      ),
                      Expanded(flex: 1, child: Container()),
                    ],
                  ),

                  /// 🔥 BUTTON
                  Container(
                    margin: EdgeInsets.only(top: 16),
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

                  /// 🔥 TITLE LIST
                  Container(
                    margin: EdgeInsets.only(top: 24),
                    child: Text(
                      "Daftar Peminjaman",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: AppColor.primary,
                      ),
                    ),
                  ),

                  /// 🔥 EMPTY STATE
                  if (controller.loans.isEmpty)
                    Container(
                      margin: EdgeInsets.only(top: 20),
                      child: Center(
                        child: Text("Belum ada data"),
                      ),
                    ),

                  /// 🔥 LIST DATA (TANPA LISTVIEW)
                  ...controller.loans.map((loan) {
                    return LoanCard(data: loan);
                  }).toList(),

                  /// 🔥 SPACING BAWAH
                  Container(
                    margin: EdgeInsets.only(bottom: 20),
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}