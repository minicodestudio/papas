class Diary {
  final String content;
  final String date;
  final String user;
  final String documentId;

  Diary({
    required this.content,
    required this.date,
    required this.user,
    required this.documentId,
  });

  factory Diary.fromJson(Map<String, dynamic> json, {required String documentId}) {
    return Diary(
      content: json['content'] as String,
      date: json['date'] as String,
      user: json['user'] as String,
      documentId: documentId,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'content': content,
      'date': date,
      'user': user,
      'documentId': documentId,
    };
  }
}
