import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';
import '../providers/review_provider.dart';
import '../models/review.dart';
import '../utils/user_session.dart';

class LeaveRatingScreen extends StatefulWidget {
  final int userId;
  final int rideId;
  final String userName;
  final Review? existingReview;

  LeaveRatingScreen({
    required this.userId,
    required this.rideId,
    required this.userName,
    this.existingReview,
  });

  @override
  _LeaveRatingScreenState createState() => _LeaveRatingScreenState();
}

class _LeaveRatingScreenState extends State<LeaveRatingScreen> {
  late int _rating;
  late TextEditingController _commentController;
  bool _isSubmitting = false;

  @override
  void initState() {
    super.initState();
    // Pre-fill values if editing an existing review
    _rating = widget.existingReview?.rating ?? 3;
    _commentController =
        TextEditingController(text: widget.existingReview?.comments ?? '');
  }

  Future<void> _submitRating() async {
    setState(() {
      _isSubmitting = true;
    });

    final review = Review(
      widget.existingReview?.reviewId,
      widget.rideId,
      widget.userId,
      UserSession.userId!,
      _rating,
      _commentController.text,
      DateTime.now(),
    );

    try {
      final reviewProvider =
          Provider.of<ReviewProvider>(context, listen: false);

      if (widget.existingReview != null) {
        // Update existing review
        await reviewProvider.update(review.reviewId!, review);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Rating updated successfully!')),
        );
      } else {
        // Insert new review
        await reviewProvider.insert(review);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Rating submitted successfully!')),
        );
      }

      Navigator.pop(context);
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to submit rating: $error')),
      );
    } finally {
      setState(() {
        _isSubmitting = false;
      });
    }
  }

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            widget.existingReview != null ? 'Edit Rating' : 'Leave a Rating'),
        backgroundColor: Colors.green.shade300,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Text(
              widget.existingReview != null
                  ? 'Edit your rating for ${widget.userName}'
                  : 'Rate your experience with ${widget.userName}',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            RatingBar.builder(
              initialRating: _rating.toDouble(),
              minRating: 1,
              direction: Axis.horizontal,
              itemCount: 5,
              unratedColor: Colors.grey.shade300,
              itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
              itemBuilder: (context, _) => Icon(
                Icons.star,
                color: Colors.green.shade600,
              ),
              onRatingUpdate: (rating) {
                setState(() {
                  _rating = rating.round();
                });
              },
            ),
            SizedBox(height: 20),
            TextField(
              controller: _commentController,
              maxLines: 5,
              decoration: InputDecoration(
                labelText: 'Leave a comment (optional)',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            _isSubmitting
                ? CircularProgressIndicator()
                : ElevatedButton(
                    onPressed: _submitRating,
                    child: Text(widget.existingReview != null
                        ? 'Update Rating'
                        : 'Submit Rating'),
                    style: ElevatedButton.styleFrom(
                      padding:
                          EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                      backgroundColor: Colors.green.shade300,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
