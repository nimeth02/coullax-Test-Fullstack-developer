class Review {
  final String id, title, author, rating, reviewText; // Fields for a review.

  Review({
    required this.id,
    required this.title,
    required this.author,
    required this.rating,
    required this.reviewText,
  });

  factory Review.fromJson(Map<String, dynamic> json) {
    return Review(
      id: json['_id'], // Parse review ID.
      title: json['title'], // Parse title.
      author: json['author'], // Parse author name.
      rating: json['rating'].toString(), // Convert rating to String.
      reviewText: json['reviewText'], // Parse review text.
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'author': author,
      'rating': rating,
      'reviewText': reviewText,
    };
  }
}