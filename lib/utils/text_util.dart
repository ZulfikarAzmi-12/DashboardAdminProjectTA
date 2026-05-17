import 'package:intl/intl.dart';

class TextUtil {
  static String loanSchedule(DateTime borrowedDate, DateTime returnDate) {
    final dateFormat = DateFormat('dd MMM yyyy');
    final timeFormat = DateFormat('HH:mm');

    // 🔥 convert UTC → local (WIB di device kamu)
    final borrowed = borrowedDate.toLocal();
    final returned = returnDate.toLocal();

    final isSameDay =
        borrowed.year == returned.year &&
        borrowed.month == returned.month &&
        borrowed.day == returned.day;

    if (isSameDay) {
      return '${dateFormat.format(borrowed)} • '
          '${timeFormat.format(borrowed)} - '
          '${timeFormat.format(returned)}';
    }

    return '${dateFormat.format(borrowed)}, ${timeFormat.format(borrowed)}\n'
        '${dateFormat.format(returned)}, ${timeFormat.format(returned)}';
  }
}
