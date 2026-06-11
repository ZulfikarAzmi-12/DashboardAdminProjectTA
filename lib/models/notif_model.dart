class NotifModel {
  final String id;
  final String title;
  final String body;
  final bool isRead;

  NotifModel({
    required this.id,
    required this.title,
    required this.body,
    required this.isRead,
  });

  factory NotifModel.fromJson(Map<String, dynamic> json) {
    return NotifModel(
      id: json['id'] as String,
      title: json['title'] as String,
      body: json['body'] as String,
      isRead: json['isRead'] as bool,
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'title': title, 'body': body, 'isRead': isRead};
  }

  NotifModel copyWith({String? id, String? title, String? body, bool? isRead}) {
    return NotifModel(
      id: id ?? this.id,
      title: title ?? this.title,
      body: body ?? this.body,
      isRead: isRead ?? this.isRead,
    );
  }
}
