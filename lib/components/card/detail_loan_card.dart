import 'package:admin_dashboard/constants/app_color.dart';
import 'package:flutter/material.dart';

class DetailLoanCard extends StatelessWidget {
  final String loanCode;
  final String status;
  final String borrowDate; // "16 Mei 2026, 06:00 s.d. 17 Mei 2026, 12:00"
  final String returnDate;
  final String acctualReturnDate;
  final String loanPurpose;

  const DetailLoanCard({
    Key? key,
    required this.loanCode,
    required this.status,
    required this.borrowDate,
    required this.returnDate,
    required this.loanPurpose,
    required this.acctualReturnDate,
  }) : super(key: key);

  Color get _statusColor {
    switch (status.toLowerCase()) {
      case "pending":
        return AppColor.pending;
      case "dipinjam":
        return AppColor.dipinjam;
      case "terlambat":
        return AppColor.terlambat;
      case "ditolak":
        return AppColor.terlambat;
      case "dikembalikan":
        return AppColor.gray;
      default:
        return AppColor.gray;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Header: Judul
          const Text(
            'Detail Peminjaman',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: AppColor.blacktext,
            ),
          ),
          const SizedBox(height: 12),

          /// Status + Loan Code
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Text(
                    'Status : ',
                    style: TextStyle(
                      fontSize: 14,
                      color: AppColor.blacktext,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    status,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: _statusColor,
                    ),
                  ),
                ],
              ),
              Text(
                loanCode,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: AppColor.blacktext, // merah
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),

          /// Tanggal Pinjam Box — menampilkan borrowDate s.d. returnDate
          _dateBoxRange(
            label: 'Tanggal Pinjam',
            startValue: borrowDate,
            endValue: returnDate,
          ),
          const SizedBox(height: 10),

          /// Tanggal Kembali Box — actual return date
          _dateBox(label: 'Tanggal Kembali', value: acctualReturnDate),
          const SizedBox(height: 14),

          /// Keperluan
          const Text(
            'Keperluan',
            style: TextStyle(
              fontSize: 14,
              color: AppColor.blacktext,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            loanPurpose,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: AppColor.blacktext,
              height: 1.5,
            ),
            maxLines: 5,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  Widget _dateBoxRange({
    required String label,
    required String startValue,
    required String endValue,
  }) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xFFE0E0E0), width: 1.5),
        borderRadius: BorderRadius.circular(10),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 14,
              color: AppColor.blacktext,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              Text(
                startValue,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: AppColor.blacktext,
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 8),
                child: Text(
                  's.d.',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: AppColor.blacktext,
                  ),
                ),
              ),
              Expanded(
                child: Text(
                  endValue,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: AppColor.blacktext,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _dateBox({required String label, required String value}) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xFFE0E0E0), width: 1.5),
        borderRadius: BorderRadius.circular(10),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 14,
              color: AppColor.blacktext,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: AppColor.blacktext,
            ),
          ),
        ],
      ),
    );
  }
}
