import 'package:admin_dashboard/models/list_loan_model.dart';
import 'package:admin_dashboard/models/loan_model.dart';
import 'package:get/get.dart';

class ListLoanController extends GetxController {
  /// ACTIVE FILTER
  RxString selectedFilter = "All".obs;

  /// DATA
  RxList<ListLoanModel> loans = <ListLoanModel>[].obs;

  /// FILTER
  final List<String> filters = [
    "All",
    "Pending",
    "Dipinjam",
    "Dikembalikan",
    "Terlambat",
  ];

  @override
  void onInit() {
    super.onInit();

    getLoans();
  }

  /// CHANGE FILTER
  void changeFilter(String value) {
    selectedFilter.value = value;
  }

  /// FILTER RESULT
  List<ListLoanModel> get filteredLoans {
    if (selectedFilter.value == "All") {
      return loans;
    }

    return loans.where((item) {
      return item.status.toLowerCase() == selectedFilter.value.toLowerCase();
    }).toList();
  }

  /// DUMMY DATA
  void getLoans() {
    loans.assignAll([
      ListLoanModel(
        code: "#PJ-5002",
        name: "Motor Supra X500",
        returnDate: "10 Mar 2025",
        status: "Pending",
        image: "",
      ),

      ListLoanModel(
        code: "#PJ-5001",
        name: "Proyektor Epson EB-X400",
        returnDate: "25 Feb 2025",
        status: "Dikembalikan",
        image: "",
      ),

      ListLoanModel(
        code: "#PJ-5003",
        name: "Karpet Musholla",
        returnDate: "5 Mar 2025",
        status: "Dipinjam",
        image: "",
      ),

      ListLoanModel(
        code: "#PJ-5004",
        name: "AC Portable 2 PK",
        returnDate: "1 Mar 2025",
        status: "Terlambat",
        image: "",
      ),
    ]);
  }
}
