import 'package:admin_dashboard/models/detail_loan_model.dart';


class LoanDetailService {
  LoanDetailModel getLoanDetail() {
    return LoanDetailModel(
      status: 'Pending',
      loanCode: '#PJ-5001',
      borrowDate: '1 Mar 2025',
      returnDate: '5 Mar 2025',
      itemName: 'Motor Supra X500',
      itemCode: 'INV-ELK-001',
      borrowerName: 'Muhammad Himmatul Fuad',
      borrowerPhone: '0821-3263-0818',
      loanPurpose:
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit',
      imageUrl: '',
    );
  }
}