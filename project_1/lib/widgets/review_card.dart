// lib/widgets/review_card.dart
import 'package:flutter/material.dart';
import '../models/review.dart';

class ReviewCard extends StatelessWidget {
  final Review review;
  final void Function(Review) onEdit;
  final void Function(String) onDelete;

  ReviewCard({required this.review, required this.onEdit, required this.onDelete});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.only(bottom: 10),
      child: ListTile(
        title: Text(review.title),
        subtitle: Text("by ${review.author} - ${review.rating} stars"),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(icon: Icon(Icons.edit), onPressed: () => onEdit(review)),
            IconButton(icon: Icon(Icons.delete), onPressed: () => onDelete(review.id)),
          ],
        ),
        onTap: () => print(review.reviewText),
      ),
    );
  }
}
