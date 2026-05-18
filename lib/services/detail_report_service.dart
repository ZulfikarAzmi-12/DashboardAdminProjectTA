import 'package:admin_dashboard/models/detail_report_model.dart';

class DetailReportService {
  Future<DetailReportModel> getLoanDetail() async {
    await Future.delayed(const Duration(seconds: 1));

    return DetailReportModel(
      status: 'Pending',
      itemName: 'Motor Supra X500',
      itemCode: 'INV-ELK-001',
      imageUrl: '',
      borrowerName: 'Mas Daus',
      reason:
          'Lorem Ipsum is simply dummy text of the printing and typesetting industry.',
    );
  }
}