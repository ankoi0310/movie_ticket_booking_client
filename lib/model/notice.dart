enum NoticeType {
  booked("BOOKED"),
  remind("REMIND");

  final String value;

  const NoticeType(this.value);

  factory NoticeType.fromValue(String value) {
    return NoticeType.values.firstWhere((e) => e.value == value);
  }
}


class Notice {
  final String description;
  final NoticeType type;
  final bool isRead;

  Notice({
    required this.description,
    required this.type,
    this.isRead = false,
  });


  factory Notice.fromJson(Map<String, dynamic> json) {
    return Notice(
      description: json['description'],
      type: NoticeType.fromValue(json['type']),
      isRead: json['isRead'],
    );
  }

  Map<String, dynamic> toJson() => {
    'description': description,
    'type': type.value,
    'isRead': isRead,
  };
}