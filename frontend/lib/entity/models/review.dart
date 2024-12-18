class Review {
  final String user;
  final String comment;
  final int? rating;

  Review({
    required this.user,
    required this.comment,
    this.rating,
  });

  factory Review.fromJson(Map<String, dynamic> json) {
    return Review(
      user: json['user'],
      comment: json['comment'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user': user,
      'comment': comment,
    };
  }
}