import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_places_flutter/google_places_flutter.dart';
import 'package:google_places_flutter/model/prediction.dart';
import 'package:hajusput_mobile/screens/route_screen.dart';
import 'package:hajusput_mobile/utils/utils.dart';
import 'package:hajusput_mobile/widgets/master_screen.dart';
import 'package:http/http.dart' as http;

class PublishScreen extends StatefulWidget {
  final bool isDropOff;
  final LatLng? pickUpLocation;
  final String? pickUpCity;
  final String? pickUpCountry;

  PublishScreen(
      {this.isDropOff = false,
      this.pickUpLocation,
      this.pickUpCity,
      this.pickUpCountry});

  @override
  _PublishScreenState createState() => _PublishScreenState();
}

class _PublishScreenState extends State<PublishScreen> {
  GoogleMapController? _mapController;
  LatLng _initialPosition =
      LatLng(37.7749, -122.4194); // Initial position (San Francisco)
  String googleApiKey = googleMapsApi;
  TextEditingController _searchController = TextEditingController();
  bool _showMap = false;
  LatLng? _selectedLocation;
  String? _selectedCity;
  String? _selectedCountry;

  @override
  Widget build(BuildContext context) {
    return MasterScreen(
      title: 'Publish Ride',
      content: Stack(
        children: <Widget>[
          if (_showMap)
            GoogleMap(
              initialCameraPosition: CameraPosition(
                target: _initialPosition,
                zoom: 12,
              ),
              onMapCreated: (GoogleMapController controller) {
                _mapController = controller;
              },
            ),
          Positioned(
            top: 60,
            left: 10,
            right: 10,
            child: placesAutoCompleteTextField(),
          ),
          if (_showMap)
            Positioned(
              bottom: 20,
              left: 10,
              right: 10,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 50, vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.green,
                ),
                onPressed: () {
                  if (widget.isDropOff) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => RouteScreen(
                          pickUpLocation: widget.pickUpLocation!,
                          dropOffLocation: _selectedLocation!,
                          pickUpCity: widget.pickUpCity!,
                          pickUpCountry: widget.pickUpCountry!,
                          dropOffCity: _selectedCity!,
                          dropOffCountry: _selectedCountry!,
                        ),
                      ),
                    );
                  } else {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PublishScreen(
                          isDropOff: true,
                          pickUpLocation: _selectedLocation,
                          pickUpCity: _selectedCity,
                          pickUpCountry: _selectedCountry,
                        ),
                      ),
                    );
                  }
                },
                child: Text(widget.isDropOff
                    ? 'Confirm Drop-off Location'
                    : 'Confirm Pick-up Location'),
              ),
            ),
        ],
      ),
      currentIndex: 1,
    );
  }

  placesAutoCompleteTextField() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: GooglePlaceAutoCompleteTextField(
        textEditingController: _searchController,
        googleAPIKey: googleApiKey,
        inputDecoration: InputDecoration(
          filled: true,
          fillColor: Colors.white70,
          hintText: "Search your location",
          border: OutlineInputBorder(),
          contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
        ),
        debounceTime: 400,
        countries: const ["de", "ba"],
        isLatLngRequired: true,
        getPlaceDetailWithLatLng: (Prediction prediction) {
          _moveToPlace(prediction);
        },
        itemClick: (Prediction prediction) {
          _searchController.text = prediction.description ?? "";
          _moveToPlace(prediction);
          FocusScope.of(context).unfocus();
        },
        isCrossBtnShown: true,
        seperatedBuilder: Divider(),
      ),
    );
  }

  Future<void> _moveToPlace(Prediction prediction) async {
    if (prediction.placeId != null) {
      final placeDetailsUrl =
          'https://maps.googleapis.com/maps/api/place/details/json?place_id=${prediction.placeId}&key=$googleApiKey';
      final response = await http.get(Uri.parse(placeDetailsUrl));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final result = data['result'];
        final location = result['geometry']['location'];
        final addressComponents = result['address_components'];

        final lat = location['lat'];
        final lng = location['lng'];

        // Debug print to check address components
        print('Address Components: $addressComponents');

        // Fetch the city with proper type checking
        final cityComponent = addressComponents.firstWhere(
          (component) {
            // Ensure 'types' is a list
            final types = component['types'];
            if (types is List && types.contains('locality')) {
              return true;
            }
            return false;
          },
          orElse: () => {'long_name': 'Unknown'}, // Default value if not found
        );
        final city = cityComponent['long_name'];

        // Fetch the country with proper type checking
        final countryComponent = addressComponents.firstWhere(
          (component) {
            // Ensure 'types' is a list
            final types = component['types'];
            if (types is List && types.contains('country')) {
              return true;
            }
            return false;
          },
          orElse: () => {'long_name': 'Unknown'}, // Default value if not found
        );
        final country = countryComponent['long_name'];

        setState(() {
          _selectedLocation = LatLng(lat, lng);
          _initialPosition = LatLng(lat, lng);
          _showMap = true;
          _mapController?.animateCamera(
            CameraUpdate.newCameraPosition(
              CameraPosition(target: LatLng(lat, lng), zoom: 12),
            ),
          );
          _selectedCity = city; // Store selected city
          _selectedCountry = country; // Store selected country
        });
      } else {
        throw Exception('Failed to load place details');
      }
    }
  }
}
