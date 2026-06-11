import 'package:admin_dashboard/components/appbar/appbar.dart';
import 'package:admin_dashboard/components/button/home_button.dart';
import 'package:admin_dashboard/components/card/loan_card.dart';
import 'package:admin_dashboard/components/card/summary_card.dart';
import 'package:admin_dashboard/constants/app_color.dart';
import 'package:admin_dashboard/routes/app_routes.dart';
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
      appBar: CustomAppBar(
        title: "Home Admin",
        actions: [
          IconButton(
            icon: Icon(Icons.notifications_none, color: AppColor.primary),
            onPressed: () {
              Get.toNamed(AppRoutes.notification);
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Obx(() {
          if (controller.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          }

          if (controller.isError.value) {
            return const Center(child: Text("Terjadi kesalahan"));
          }

          // ── RefreshIndicator wrap SingleChildScrollView ──────────────
          return RefreshIndicator(
            color: AppColor.primary,
            onRefresh: controller.refresh,
            child: SingleChildScrollView(
              // ── Wajib agar RefreshIndicator selalu bisa dipicu ────────
              physics: const AlwaysScrollableScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Ringkasan",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: AppColor.blacktext,
                      ),
                    ),
                    const SizedBox(height: 10),

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
                      margin: const EdgeInsets.only(top: 10, bottom: 10),
                      child: Row(
                        children: [
                          Expanded(
                            child: HomeButton(
                              text: "Tambah Barang",
                              icon: Icons.add,
                              onPressed: () {
                                Get.toNamed(AppRoutes.addInventory);
                              },
                            ),
                          ),
                          Expanded(
                            child: Container(
                              margin: const EdgeInsets.only(left: 12),
                              child: HomeButton(
                                text: "Kelola User",
                                icon: Icons.person,
                                onPressed: () {
                                  Get.toNamed(AppRoutes.manageUser);
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    Container(
                      margin: const EdgeInsets.only(top: 10, bottom: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Peminjaman",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: AppColor.blacktext,
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              Get.toNamed(AppRoutes.listLoan);
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
                                const SizedBox(width: 5),
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
                        margin: const EdgeInsets.only(top: 20),
                        alignment: Alignment.center,
                        child: const Text("Belum ada data"),
                      )
                    else
                      ListView.builder(
                        shrinkWrap: true,
                        // ── NeverScrollableScrollPhysics karena scroll
                        //    sudah dihandle SingleChildScrollView ─────────
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: controller.loans.length,
                        itemBuilder: (context, index) {
                          final loan = controller.loans[index];
                          return LoanCard(
                            data: loan,
                            onPresed: () => Get.toNamed(
                              AppRoutes.detailLoan,
                              arguments: loan.id,
                            ),
                          );
                        },
                      ),

                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
