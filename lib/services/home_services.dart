import 'package:admin_dashboard/models/loan_models.dart';

class HomeService {
  Future<List<LoanModel>> fetchLoans() async {
    await Future.delayed(Duration(seconds: 1));

    final response = {
      "success": true,
      "data": [
        {
          'status': 'Dikembalikan',
          'kode': '#PJ-5001',
          'nama': 'Proyektor Epson EB-X400',
          'tanggal': '25 Feb 2025',
        },
        {
          'status': 'Dipinjam',
          'kode': '#PJ-5002',
          'nama': 'Karpet musholla',
          'tanggal': '5 Mar 2025',
        },
        {
          'status': 'Terlambat',
          'kode': '#PJ-5003',
          'nama': 'AC Portable 2 PK',
          'tanggal': '1 Mar 2025',
        },
        {
          'status': 'Pending',
          'kode': '#PJ-5004',
          'nama': 'Motor Supra X500',
          'tanggal': '10 Mar 2025',
        },
      ],
    };

    final data = response['data'] as List;

    return data.map((e) => LoanModel.fromJson(e)).toList();
  }
}
