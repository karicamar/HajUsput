import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hajusput_mobile/models/ride.dart';
import 'package:hajusput_mobile/screens/date_time_screen.dart'; // Import DateTimeScreen here
import 'package:hajusput_mobile/utils/utils.dart';
import 'package:hajusput_mobile/models/location.dart';
import 'package:hajusput_mobile/providers/location_provider.dart';
import 'package:http/http.dart' as http;

class RouteScreen extends StatefulWidget {
  final LatLng pickUpLocation;
  final LatLng dropOffLocation;
  final String pickUpCity;
  final String pickUpCountry;
  final String dropOffCity;
  final String dropOffCountry;

  RouteScreen({
    required this.pickUpLocation,
    required this.dropOffLocation,
    required this.pickUpCity,
    required this.pickUpCountry,
    required this.dropOffCity,
    required this.dropOffCountry,
  });

  @override
  _RouteScreenState createState() => _RouteScreenState();
}

class _RouteScreenState extends State<RouteScreen> {
  late Ride updatedRide;
  GoogleMapController? _mapController;
  Set<Polyline> _polylines = {};
  double _distance = 0.0;
  int _durationHours = 0; // in hours
  int _durationMinutes = 0;
  double totalDurationMinutes = 0.0; // in minutes
  final LocationProvider _locationProvider = LocationProvider();
  bool _isLoading = false; // Add this state variable

  @override
  void initState() {
    super.initState();
    _calculateRoute();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Route'),
      ),
      body: Stack(
        children: [
          Column(
            children: [
              Expanded(
                child: GoogleMap(
                  initialCameraPosition: CameraPosition(
                    target: widget.pickUpLocation,
                    zoom: 10,
                  ),
                  onMapCreated: (GoogleMapController controller) {
                    _mapController = controller;
                    _moveToRoute();
                  },
                  polylines: _polylines,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Distance: ${_distance.toStringAsFixed(2)} km, Duration: ${_durationHours}h ${_durationMinutes}m',
                ),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.green.shade300,
                ),
                onPressed: _isLoading
                    ? null
                    : () async {
                        setState(() {
                          _isLoading =
                              true; // Show loader when button is pressed
                        });

                        totalDurationMinutes =
                            ((_durationHours * 60) + _durationMinutes)
                                .toDouble();
                        await _createUpdatedRide();
                        print(
                            'Response status: ${updatedRide.departureLocationId}, ${updatedRide.destinationLocationId}, ${updatedRide.distance}, ${updatedRide.duration}');

                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DateTimeScreen(
                              ride: updatedRide, // Pass the updated ride
                            ),
                          ),
                        );

                        setState(() {
                          _isLoading = false; // Hide loader after navigation
                        });
                      },
                child: Text('Confirm Route'),
              ),
            ],
          ),
          if (_isLoading)
            Center(
              child: CircularProgressIndicator(), // Add the progress indicator
            ),
        ],
      ),
    );
  }

  Future<void> _calculateRoute() async {
    final directionsUrl =
        'https://maps.googleapis.com/maps/api/directions/json?origin=${widget.pickUpLocation.latitude},${widget.pickUpLocation.longitude}&destination=${widget.dropOffLocation.latitude},${widget.dropOffLocation.longitude}&key=$googleMapsApi';
    final response = await http.get(Uri.parse(directionsUrl));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final route = data['routes'][0]['overview_polyline']['points'];
      final polylinePoints = _decodePolyline(route);
      final polyline = Polyline(
        polylineId: PolylineId('route'),
        points: polylinePoints,
        color: Colors.blue,
        width: 5,
      );

      final distanceMeters = data['routes'][0]['legs'][0]['distance']['value'];
      final distanceKm = distanceMeters / 1000.0;

      final durationSeconds = data['routes'][0]['legs'][0]['duration']['value'];
      final durationHours = (durationSeconds / 3600).floor();
      final durationMinutes = ((durationSeconds % 3600) / 60).round();

      setState(() {
        _polylines.add(polyline);
        _distance = distanceKm;
        _durationHours = durationHours;
        _durationMinutes = durationMinutes;
      });
    } else {
      throw Exception('Failed to load directions');
    }
  }

  List<LatLng> _decodePolyline(String polyline) {
    var points = polyline.codeUnits;
    var decoded = [];
    var index = 0;
    int len = polyline.length;
    int lat = 0;
    int lng = 0;

    while (index < len) {
      var b, shift = 0, result = 0;
      do {
        b = points[index++] - 63;
        result |= (b & 0x1f) << shift;
        shift += 5;
      } while (b >= 0x20);
      int dlat = ((result & 1) != 0 ? ~(result >> 1) : (result >> 1));
      lat += dlat;

      shift = 0;
      result = 0;
      do {
        b = points[index++] - 63;
        result |= (b & 0x1f) << shift;
        shift += 5;
      } while (b >= 0x20);
      int dlng = ((result & 1) != 0 ? ~(result >> 1) : (result >> 1));
      lng += dlng;

      decoded.add(LatLng(lat / 1E5, lng / 1E5));
    }

    return decoded.cast<LatLng>();
  }

  void _moveToRoute() {
    final bounds = LatLngBounds(
      southwest: LatLng(
        widget.pickUpLocation.latitude < widget.dropOffLocation.latitude
            ? widget.pickUpLocation.latitude
            : widget.dropOffLocation.latitude,
        widget.pickUpLocation.longitude < widget.dropOffLocation.longitude
            ? widget.pickUpLocation.longitude
            : widget.dropOffLocation.longitude,
      ),
      northeast: LatLng(
        widget.pickUpLocation.latitude > widget.dropOffLocation.latitude
            ? widget.pickUpLocation.latitude
            : widget.dropOffLocation.latitude,
        widget.pickUpLocation.longitude > widget.dropOffLocation.longitude
            ? widget.pickUpLocation.longitude
            : widget.dropOffLocation.longitude,
      ),
    );

    _mapController?.animateCamera(CameraUpdate.newLatLngBounds(bounds, 50));
  }

  Future<int> _getOrCreateLocationId(String city, String country) async {
    final locationResult = await _locationProvider.fetchLocationId(city);
    if (locationResult == null) {
      final newLocation = Location(null, city, country);
      final createdLocation = await _locationProvider.insert(newLocation);
      return createdLocation.locationId!;
    } else {
      return locationResult;
    }
  }

  Future<void> _createUpdatedRide() async {
    final pickUpLocationId =
        await _getOrCreateLocationId(widget.pickUpCity, widget.pickUpCountry);
    final dropOffLocationId =
        await _getOrCreateLocationId(widget.dropOffCity, widget.dropOffCountry);

    // Create the updated ride with the location IDs
    updatedRide = Ride(
      null, // rideId (null for a new ride)
      null, // driverId (set later when creating the ride in the backend)
      pickUpLocationId, // departureLocationId
      dropOffLocationId, // destinationLocationId
      null, // departureDate (set in the DateTimeScreen)
      _distance, // distance
      totalDurationMinutes, // duration in minutes
      null, // availableSeats (set later)
      'Pending', // rideStatus
      null, // price (set later)
    );
  }
}
