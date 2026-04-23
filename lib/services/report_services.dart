

import 'package:admin_dashboard/models/report_model.dart';

class ReportService {
  Future<List<ReportModel>> fetchReports() async {
    await Future.delayed(const Duration(seconds: 1));

    return [
      ReportModel(
        id: "1",
        title: "Camera canon g7x m5",
        code: "INV-ELK-001",
        complaint: "Lorem Ipsum is simply dummy text of the printing and typesetting industry.....",
        status: "Pending",
      ),
      ReportModel(
        id: "2",
        title: "Camera canon g7x m5",
        code: "INV-ELK-001",
        complaint: "Lorem Ipsum is simply dummy text of the printing and typesetting industry.....",
        status: "Diproses",
      ),
      ReportModel(
        id: "3",
        title: "Camera canon g7x m5",
        code: "INV-ELK-001",
        complaint: "Lorem Ipsum is simply dummy text of the printing and typesetting industry.....",
        status: "Selesai",
      ),
    ];
  }
}