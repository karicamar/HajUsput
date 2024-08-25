import 'package:flutter/material.dart';
import 'package:hajusput_mobile/models/review.dart';
import 'package:hajusput_mobile/providers/review_provider.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class RatingsScreen extends StatefulWidget {
  final int userId;
  const RatingsScreen({super.key, required this.userId});

  @override
  _RatingsScreenState createState() => _RatingsScreenState();
}

class _RatingsScreenState extends State<RatingsScreen>
    with SingleTickerProviderStateMixin {
  Map<String, List<Review>>? ratings;
  bool isLoading = true;
  late TabController _tabController;
  double? averageRating;
  int totalRatingsCount = 0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _fetchRatings();
  }

  Future<void> _fetchRatings() async {
    final reviewRatingProvider =
        Provider.of<ReviewProvider>(context, listen: false);

    try {
      final fetchedRatings =
          await reviewRatingProvider.getRatingsByUser(widget.userId);
      final fetchedAverageRating =
          await reviewRatingProvider.getDriverRating(widget.userId);
      final fetchedTotalRatingsCount =
          await reviewRatingProvider.getTotalRatingsCount(widget.userId);

      setState(() {
        ratings = fetchedRatings;
        averageRating = fetchedAverageRating ?? 0.0;
        totalRatingsCount = fetchedTotalRatingsCount;
      });
    } catch (e) {
      print('Error fetching ratings: $e');
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Ratings',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8), // Adding space between title and rating count
            if (!isLoading && ratings != null)
              Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.star, color: Colors.amber, size: 20),
                  Text(
                    ' ${averageRating?.toStringAsFixed(1)}/5 - $totalRatingsCount ratings',
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
          ],
        ),
        bottom: TabBar(
          labelColor: Colors.green.shade600,
          indicatorColor: Colors.green.shade600,
          controller: _tabController,
          tabs: [
            Tab(text: 'Given Reviews'),
            Tab(text: 'Received Reviews'),
          ],
        ),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : ratings == null ||
                  (ratings!["GivenReviews"]!.isEmpty &&
                      ratings!["ReceivedReviews"]!.isEmpty)
              ? Center(child: Text('No ratings available.'))
              : Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.white,
                        Colors.green.shade300,
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                  child: TabBarView(
                    controller: _tabController,
                    children: [
                      _buildRatingSection(
                          "Given Reviews", ratings!["GivenReviews"]!),
                      _buildRatingSection(
                          "Received Reviews", ratings!["ReceivedReviews"]!),
                    ],
                  ),
                ),
    );
  }

  Widget _buildRatingSection(String title, List<Review> reviews) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView.builder(
        itemCount: reviews.length,
        itemBuilder: (context, index) {
          final review = reviews[index];
          return Card(
            margin: EdgeInsets.symmetric(vertical: 8.0),
            child: ListTile(
              contentPadding: EdgeInsets.all(12.0),
              title: Text(
                'Rating: ${review.rating.toString()}',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 4),
                  Text(
                    review.comments,
                    style: TextStyle(fontSize: 14),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Date: ${DateFormat('dd MMM yyyy').format(review.reviewDate)}',
                    style: TextStyle(color: Colors.grey, fontSize: 12),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
