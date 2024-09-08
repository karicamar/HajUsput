import 'package:json_annotation/json_annotation.dart';

/// This allows the `User` class to access private members in
/// the generated file. The value for this is *.g.dart, where
/// the star denotes the source file name.
part 'car.g.dart';

@JsonSerializable()
class Car {
  Car(this.carId, this.driverId, this.make, this.carType, this.color,
      this.yearOfManufacture, this.licensePlateNumber);

  int? carId;
  int? driverId;
  String make;
  String carType;
  String color;
  int? yearOfManufacture;
  String? licensePlateNumber;

  /// A necessary factory constructor for creating a new User instance
  /// from a map. Pass the map to the generated `_$UserFromJson()` constructor.
  /// The constructor is named after the source class, in this case, User.
  factory Car.fromJson(Map<String, dynamic> json) => _$CarFromJson(json);

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$UserToJson`.
  Map<String, dynamic> toJson() => _$CarToJson(this);
}
