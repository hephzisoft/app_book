class Books {
  final String id;
  final String title;
  final String author;
  final bool isPaid;
  final String content;

  Books(
      {required this.id,
      required this.title,
      required this.author,
      required this.isPaid,
      required this.content});

  factory Books.fromSqfliteDatabase(Map<String, dynamic> map) => Books(
        id: map['id'] ?? '',
        title: map['title'] ?? '',
        author: map['author'] ?? '',
        content: map['content'] ?? '',
        isPaid: map['isPaid'] ?? false,
      );
}
