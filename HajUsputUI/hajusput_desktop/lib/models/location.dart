import 'package:json_annotation/json_annotation.dart';

/// This allows the `User` class to access private members in
/// the generated file. The value for this is *.g.dart, where
/// the star denotes the source file name.
part 'location.g.dart';

@JsonSerializable()
class Location {
  Location(this.locationId, this.city, this.country);
  int? locationId;
  String city;
  String country;
// Named constructor for default/placeholder values
  Location.defaultPlaceholder()
      : locationId = null,
        city = 'Select a city',
        country = '';

  /// A necessary factory constructor for creating a new User instance
  /// from a map. Pass the map to the generated `_$UserFromJson()` constructor.
  /// The constructor is named after the source class, in this case, User.
  factory Location.fromJson(Map<String, dynamic> json) =>
      _$LocationFromJson(json);

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$UserToJson`.
  Map<String, dynamic> toJson() => _$LocationToJson(this);
}
