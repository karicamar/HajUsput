import 'package:json_annotation/json_annotation.dart';

/// This allows the `User` class to access private members in
/// the generated file. The value for this is *.g.dart, where
/// the star denotes the source file name.
part 'review.g.dart';

@JsonSerializable()
class Review {
  Review(this.reviewId, this.driverId, this.reviewerId, this.rating,
      this.comments, this.reviewDate);

  int? reviewId;
  int? driverId;
  int? reviewerId;
  int? rating;
  String comments;
  DateTime reviewDate;

  /// A necessary factory constructor for creating a new User instance
  /// from a map. Pass the map to the generated `_$UserFromJson()` constructor.
  /// The constructor is named after the source class, in this case, User.
  factory Review.fromJson(Map<String, dynamic> json) => _$ReviewFromJson(json);

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$UserToJson`.
  Map<String, dynamic> toJson() => _$ReviewToJson(this);
}
//  "reviewId": 0,
//       "driverId": 0,
//       "reviewerId": 0,
//       "rating": 0,
//       "comments": "string",
//       "reviewDate": "2024-08-01T22:11:36.414Z"