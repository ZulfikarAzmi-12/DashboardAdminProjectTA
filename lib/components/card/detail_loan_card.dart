import 'package:admin_dashboard/constants/app_color.dart';
import 'package:flutter/material.dart';

class DetailLoanCard extends StatelessWidget {
  final String borrowerName;
  final String borrowerPhone;
  final String borrowDate;
  final String returnDate;
  final String loanPurpose;

  const DetailLoanCard({
    Key? key,
    required this.borrowerName,
    required this.borrowerPhone,
    required this.borrowDate,
    required this.returnDate,
    required this.loanPurpose,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColor.background,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: AppColor.blacktext,
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// SECTION 1: INFORMASI PEMINJAM
          const Text(
            'Informasi Peminjam',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: AppColor.blacktext,
            ),
          ),
          const SizedBox(height: 12),
          _buildInfoRow('Nama:', borrowerName),
          const SizedBox(height: 8),
          _buildInfoRow('No Telepon:', borrowerPhone),

          const SizedBox(height: 20),
          Divider(color: AppColor.lightgray, height: 1),
          const SizedBox(height: 20),

          /// SECTION 2: DETAIL PEMINJAMAN
          const Text(
            'Detail Peminjaman',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: AppColor.blacktext,
            ),
          ),
          const SizedBox(height: 12),

          /// Tanggal Pinjam & Tanggal Kembali
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Tanggal Pinjam:',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        color: AppColor.gray,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      borrowDate,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: AppColor.blacktext,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Tanggal Kembali:',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        color: AppColor.gray,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      returnDate,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: AppColor.blacktext,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),

          /// Keterangan/Tujuan
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Keterangan:',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey[700],
                ),
              ),
              const SizedBox(height: 4),
              Text(
                loanPurpose,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
                  color: Color(0xFF424242),
                ),
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w500,
            color: Colors.grey[700],
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w600,
            color: Color(0xFF212121),
          ),
        ),
      ],
    );
  }
}
