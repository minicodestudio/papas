class Diary {
  final String content;
  final String date;
  final String user;

  Diary({
    required this.content,
    required this.date,
    required this.user,
  });

  factory Diary.fromJson(Map<String, dynamic> json) {
    return Diary(
      content: json['content'] as String,
      date: json['date'] as String,
      user: json['user'] as String,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'content': content,
      'date': date,
      'user': user,
    };
  }
}
