class Comment {
  final int id;
  final String comment;
  final String date;
  final String userName;
  final String userImage;

  Comment({
    required this.id,
    required this.comment,
    required this.date,
    required this.userName,
    required this.userImage,
  });

  factory Comment.fromJson(Map<String, dynamic> json) {
    return Comment(
      id: json['id'] ?? 0,
      comment: json['content'] ?? '',
      date: json['created_at'] ?? '',
      userName: json['author_name'] ?? json['author']?['name'] ?? 'Unknown',
      userImage: json['author']?['avatar'] ?? '',
    );
  }
}
