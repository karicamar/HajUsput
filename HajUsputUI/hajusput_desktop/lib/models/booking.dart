import 'package:json_annotation/json_annotation.dart';

/// This allows the `User` class to access private members in
/// the generated file. The value for this is *.g.dart, where
/// the star denotes the source file name.
part 'booking.g.dart';

@JsonSerializable()
class Booking {
  Booking(this.bookingId, this.rideId, this.passengerId, this.bookingStatus,
      this.bookingDate, this.paymentId);
  int? bookingId;
  int? rideId;
  int? passengerId;
  String? bookingStatus;
  DateTime? bookingDate;
  int? paymentId;

  /// A necessary factory constructor for creating a new User instance
  /// from a map. Pass the map to the generated `_$UserFromJson()` constructor.
  /// The constructor is named after the source class, in this case, User.
  factory Booking.fromJson(Map<String, dynamic> json) =>
      _$BookingFromJson(json);

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$UserToJson`.
  Map<String, dynamic> toJson() => _$BookingToJson(this);
}
