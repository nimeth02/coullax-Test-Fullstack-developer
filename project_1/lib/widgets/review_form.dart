// lib/widgets/review_form.dart
import 'package:flutter/material.dart';
import '../models/review.dart';
import '../services/review_service.dart';

class ReviewForm extends StatefulWidget {
  final void Function() onSubmit;
  final Review? editingReview;

  ReviewForm({required this.onSubmit, this.editingReview});

  @override
  _ReviewFormState createState() => _ReviewFormState();
}

class _ReviewFormState extends State<ReviewForm> {
  final ReviewService reviewService = ReviewService();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController authorController = TextEditingController();
  final TextEditingController ratingController = TextEditingController();
  final TextEditingController reviewTextController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.editingReview != null) {
      titleController.text = widget.editingReview!.title;
      authorController.text = widget.editingReview!.author;
      ratingController.text = widget.editingReview!.rating;
      reviewTextController.text = widget.editingReview!.reviewText;
    }
  }

  void handleSubmit() async {
    final review = Review(
      id: widget.editingReview?.id ?? '', // Generate a new ID for new reviews.
      title: titleController.text,
      author: authorController.text,
      rating: ratingController.text,
      reviewText: reviewTextController.text,
    );
    print(review);
    try {
      if (widget.editingReview != null) {

        await reviewService.updateReview(review);
      } else {

        await reviewService.addReview(review);
      }

      await reviewService.fetchReviews();

      widget.onSubmit();
    } catch (e) {

      print("Error: $e");

    }

    titleController.clear();
    authorController.clear();
    ratingController.clear();
    reviewTextController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextField(controller: titleController, decoration: InputDecoration(labelText: "Book Title")),
          TextField(controller: authorController, decoration: InputDecoration(labelText: "Author")),
          TextField(controller: ratingController, decoration: InputDecoration(labelText: "Rating (1-5)")),
          TextField(controller: reviewTextController, decoration: InputDecoration(labelText: "Your Review"), maxLines: 4),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: handleSubmit,
            child: Text(widget.editingReview != null ? "Update Review" : "Add Review"),
          ),
        ],
      ),
    );
  }
}
