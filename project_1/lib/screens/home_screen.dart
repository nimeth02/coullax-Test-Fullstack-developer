// lib/screens/home_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import '../models/review.dart';
import '../services/review_service.dart';
import '../widgets/review_form.dart';
import '../widgets/review_card.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ReviewService reviewService = ReviewService();
  List<Review> reviews = [];
  Review? editingReview;

  @override
  void initState() {
    super.initState();
    fetchReviews();
  }

  Future<void> fetchReviews() async {
    try {
      List<Review> fetchedReviews = await reviewService.fetchReviews();
      setState(() {
        reviews = fetchedReviews;
      });
    } catch (error) {
      if (kDebugMode) {
        print('Error fetching reviews: $error');
      }
    }
  }

  void handleEdit(Review review) {
    setState(() {
      editingReview = review;
    });
  }

  void handleDelete(String id) async {
    await reviewService.deleteReview(id);
    fetchReviews();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Book Reviews")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            ReviewForm(
              onSubmit: fetchReviews,
              editingReview: editingReview,
            ),
            Expanded(
              child: ListView.builder(
                itemCount: reviews.length,
                itemBuilder: (context, index) {
                  return ReviewCard(
                    review: reviews[index],
                    onEdit: handleEdit,
                    onDelete: handleDelete,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
