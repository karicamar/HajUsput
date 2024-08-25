import 'package:json_annotation/json_annotation.dart';

/// This allows the `User` class to access private members in
/// the generated file. The value for this is *.g.dart, where
/// the star denotes the source file name.
part 'ride.g.dart';

@JsonSerializable()
class Ride {
  Ride(
    this.rideId,
    this.driverId,
    this.departureLocationId,
    this.destinationLocationId,
    this.departureDate,
    this.distance,
    this.duration,
    this.availableSeats,
    this.rideStatus,
    this.price,
  );
  int? rideId;
  int? driverId;
  int departureLocationId;
  int destinationLocationId;
  DateTime? departureDate;
  double? distance;
  double? duration;
  int? availableSeats;
  String? rideStatus;
  int? price;

  /// A necessary factory constructor for creating a new User instance
  /// from a map. Pass the map to the generated `_$UserFromJson()` constructor.
  /// The constructor is named after the source class, in this case, User.
  factory Ride.fromJson(Map<String, dynamic> json) => _$RideFromJson(json);

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$UserToJson`.
  Map<String, dynamic> toJson() => _$RideToJson(this);
}
