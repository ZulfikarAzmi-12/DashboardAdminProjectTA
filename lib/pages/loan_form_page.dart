import 'package:admin_dashboard/components/appbar/appbar.dart';
import 'package:admin_dashboard/components/button/big_button.dart';
import 'package:admin_dashboard/components/card/schedule_card.dart';
import 'package:admin_dashboard/components/textfield/loan_text_area.dart';
import 'package:admin_dashboard/components/textfield/loan_textfield.dart';
import 'package:admin_dashboard/components/textfield/selector_textfield.dart';
import 'package:admin_dashboard/constants/app_color.dart';
import 'package:admin_dashboard/controller/loan_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoanFormPage extends StatelessWidget {
  LoanFormPage({super.key});

  final controller = Get.find<LoanController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.background,
      appBar: CustomAppBar(
        title: "Catat Peminjaman",
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Get.back(),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ── Tgl Peminjaman ──────────────────────────────────────
              Obx(
                () => DateTimePickerField(
                  hint: 'Tgl Peminjaman',
                  selectedDate: controller.tglPeminjaman.value,
                  onDateSelected: (date) =>
                      controller.tglPeminjaman.value = date,
                ),
              ),

              const SizedBox(height: 12),

              // ── Tgl Pengembalian ────────────────────────────────────
              Obx(
                () => DateTimePickerField(
                  hint: 'Tgl Pengembalian',
                  selectedDate: controller.tglPengembalian.value,
                  onDateSelected: (date) =>
                      controller.tglPengembalian.value = date,
                ),
              ),

              const SizedBox(height: 12),

              // ── Keperluan ───────────────────────────────────────────
              LoanTextArea(
                controller: controller.purposeC,
                hint: 'Keperluan Peminjaman..',
              ),

              const SizedBox(height: 12),

              // ── Selector Peminjam ───────────────────────────────────
              Obx(
                () => CustomSelector<BorrowerOption>(
                  selectedValue: controller.selectedBorrower,
                  options: controller.borrowerOptions,
                  hint: 'Peminjam',
                  labelBuilder: (item) => item.name,
                  valueBuilder: (item) => item.id,
                ),
              ),

              const SizedBox(height: 4),

              // ── Tombol Pinjam ───────────────────────────────────────
              Obx(
                () => BigButton(
                  title: controller.isLoadingBorrow.value
                      ? 'Memproses...'
                      : 'Pinjam',
                  onTap: controller.isLoadingBorrow.value
                      ? () {}
                      : () => controller.borrowUnit(),
                ),
              ),

              const SizedBox(height: 20),

              // ── Jadwal Peminjaman ───────────────────────────────────
              const Text(
                'Jadwal Peminjaman',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),

              const SizedBox(height: 10),

              Obx(() {
                if (controller.isLoadingSchedule.value) {
                  return const Center(
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 24),
                      child: CircularProgressIndicator(),
                    ),
                  );
                }

                if (controller.schedules.isEmpty) {
                  return const Center(
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 24),
                      child: Text(
                        'Belum ada jadwal peminjaman',
                        style: TextStyle(color: Colors.grey),
                      ),
                    ),
                  );
                }

                return ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: controller.schedules.length,
                  itemBuilder: (context, index) {
                    final schedule = controller.schedules[index];
                    return ScheduleCard(
                      borrowedDate: schedule.borrowedDate,
                      returnDate: schedule.returnDate,
                      status: schedule.status,
                    );
                  },
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
