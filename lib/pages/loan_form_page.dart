import 'package:admin_dashboard/components/appbar/appbar.dart';
import 'package:admin_dashboard/components/button/big_button.dart';
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
        title: "Tambahkan Peminjaman",
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Get.back(),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Column(
            children: [
              LoanTextfield(
                controller: controller.borrowDateC,
                hint: 'Tgl Peminjaman',
                icon: Icons.calendar_today_outlined,
                readOnly: true,
              ),

              const SizedBox(height: 12),

              LoanTextfield(
                controller: controller.returnDateC,
                hint: 'Tgl Pengembalian',
                icon: Icons.calendar_today_outlined,
                readOnly: true,
              ),

              const SizedBox(height: 12),

              LoanTextArea(
                controller: controller.purposeC,
                hint: 'Keperluan Peminjaman..',
              ),

              const SizedBox(height: 12),

              CustomSelector(
                selectedValue: controller.selectedBorrower,
                options: controller.borrowerOptions,
                hint: 'Peminjam',
              ),

              const SizedBox(height: 4),

              BigButton(
                title: 'Pinjam',
                onTap: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}