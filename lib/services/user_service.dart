import 'package:admin_dashboard/models/user_model.dart';

class UserService {
  Future<List<UserModel>> getUsers() async {
    await Future.delayed(const Duration(milliseconds: 500));

    final response = [
      {
        "id": 1,
        "name": "Roy Suryo",
        "email": "example@gmail.com",
        "phone": "0821-3263-0818",
        "role": "User",
      },
      {
        "id": 2,
        "name": "Doni Kus",
        "email": "example@gmail.com",
        "phone": "0821-3263-0818",
        "role": "Admin",
      },
    ];

    return response.map((e) => UserModel.fromJson(e)).toList();
  }
}
