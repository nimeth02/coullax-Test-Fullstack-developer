import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import '../models/review.dart';

class ReviewService {
  final String baseUrl = 'http://192.168.43.45:5000/reviews';

  Future<List<Review>> fetchReviews() async {
    final response = await http.get(Uri.parse(baseUrl));
    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((review) => Review.fromJson(review)).toList();
    } else {
      throw Exception('Failed to load reviews');
    }
  }

  Future<void> addReview(Review review) async {
    final response = await http.post(
      Uri.parse(baseUrl),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(review.toJson()),
    );
    if (response.statusCode != 201) {
      throw Exception('Failed to add review');
    }
  }

  Future<void> updateReview(Review review) async {
    final response = await http.put(
      Uri.parse('$baseUrl/${review.id}'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(review.toJson()),
    );
    if (response.statusCode != 200) {
      throw Exception('Failed to update review');
    }
  }

  Future<void> deleteReview(String id) async {
    final response = await http.delete(Uri.parse('$baseUrl/$id'));
    if (response.statusCode != 204) {
      throw Exception('Failed to delete review');
    }
  }
}