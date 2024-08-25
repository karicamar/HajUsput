import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:hajusput_desktop/models/location.dart';
import 'package:hajusput_desktop/models/ride.dart';
import 'package:hajusput_desktop/models/search_result.dart';
import 'package:hajusput_desktop/screens/ride_details_screen.dart';
import 'package:provider/provider.dart';
import '../providers/ride_provider.dart';
import '../providers/location_provider.dart';
import '../widgets/master_screen.dart';

class RidesScreen extends StatefulWidget {
  @override
  _RidesScreenState createState() => _RidesScreenState();
}

class _RidesScreenState extends State<RidesScreen> {
  late Future<SearchResult<Ride>> _ridesFuture;
  late Future<SearchResult<Location>> _locationsFuture;
  late LocationProvider _locationProvider;
  late RideProvider _rideProvider;
  int _currentPage = 1;
  final int _pageSize = 5;
  int? _selectedDepartureCityId;
  int? _selectedDestinationCityId;

  @override
  void initState() {
    super.initState();
    _locationProvider = Provider.of<LocationProvider>(context, listen: false);
    _rideProvider = Provider.of<RideProvider>(context, listen: false);
    _fetchLocations();
    _fetchRides();
  }

  Future<void> _fetchLocations() async {
    _locationsFuture = _locationProvider
        .get(); // Assuming get() returns Future<SearchResult<Location>>
    setState(() {});
  }

  void _fetchRides() {
    setState(() {
      _ridesFuture = _rideProvider.get(
        filter: {
          'page': _currentPage - 1,
          'pageSize': _pageSize,
          'departureLocationId': _selectedDepartureCityId,
          'destinationLocationId': _selectedDestinationCityId,
        },
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return MasterScreen(
      title: 'Rides',
      body: Column(
        children: [
          _buildFilters(),
          Expanded(
            child: FutureBuilder<SearchResult<Ride>>(
              future: _ridesFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error loading rides'));
                } else if (!snapshot.hasData || snapshot.data!.result.isEmpty) {
                  return Center(child: Text('No rides available'));
                }

                final rides = snapshot.data!.result;

                return Column(
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: DataTable(
                          columns: [
                            DataColumn(label: Text('Ride ID')),
                            DataColumn(label: Text('Departure Location')),
                            DataColumn(label: Text('Destination Location')),
                            DataColumn(label: Text('Departure Date')),
                            DataColumn(label: Text('Status')),
                            DataColumn(label: Text('Actions')),
                          ],
                          rows: rides.map((ride) {
                            return DataRow(
                              cells: [
                                DataCell(Text(ride.rideId.toString())),
                                DataCell(FutureBuilder<String>(
                                  future: _fetchLocationName(
                                      ride.departureLocationId),
                                  builder: (context, locationSnapshot) {
                                    if (locationSnapshot.connectionState ==
                                        ConnectionState.waiting) {
                                      return Text('Loading...');
                                    } else if (locationSnapshot.hasError) {
                                      return Text('Error loading');
                                    } else if (!locationSnapshot.hasData) {
                                      return Text('No data');
                                    }
                                    return Text(locationSnapshot.data!);
                                  },
                                )),
                                DataCell(FutureBuilder<String>(
                                  future: _fetchLocationName(
                                      ride.destinationLocationId),
                                  builder: (context, locationSnapshot) {
                                    if (locationSnapshot.connectionState ==
                                        ConnectionState.waiting) {
                                      return Text('Loading...');
                                    } else if (locationSnapshot.hasError) {
                                      return Text('Error loading');
                                    } else if (!locationSnapshot.hasData) {
                                      return Text('No data');
                                    }
                                    return Text(locationSnapshot.data!);
                                  },
                                )),
                                DataCell(Text(ride.departureDate.toString())),
                                DataCell(Text(ride.rideStatus.toString())),
                                DataCell(
                                  IconButton(
                                    icon: Icon(Icons.info),
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              RideDetailsScreen(ride: ride),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ],
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                    if (snapshot.hasData)
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IconButton(
                              icon: Icon(Icons.arrow_back),
                              onPressed: _currentPage > 1
                                  ? () {
                                      setState(() {
                                        _currentPage--;
                                        _fetchRides();
                                      });
                                    }
                                  : null,
                            ),
                            Text(
                                'Page $_currentPage of ${((snapshot.data!.count / _pageSize).ceil())}'),
                            IconButton(
                              icon: Icon(Icons.arrow_forward),
                              onPressed: snapshot.data!.count >
                                      _currentPage * _pageSize
                                  ? () {
                                      setState(() {
                                        _currentPage++;
                                        _fetchRides();
                                      });
                                    }
                                  : null,
                            ),
                          ],
                        ),
                      ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Future<String> _fetchLocationName(int locationId) async {
    final locationResult = await _locationProvider.getById(locationId);
    return locationResult.city;
  }

  Widget _buildFilters() {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Row(
        children: [
          Expanded(
            child: FutureBuilder<SearchResult<Location>>(
              future: _locationsFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text('Error loading locations');
                } else if (!snapshot.hasData || snapshot.data!.result.isEmpty) {
                  return Text('No locations available');
                }

                final locations = snapshot.data!.result;

                return DropdownSearch<Location>(
                  items: locations,
                  itemAsString: (Location loc) => loc.city,
                  onChanged: (Location? newValue) {
                    setState(() {
                      _selectedDepartureCityId = newValue?.locationId;
                      _currentPage = 1;
                      _fetchRides();
                    });
                  },
                  dropdownDecoratorProps: DropDownDecoratorProps(
                    dropdownSearchDecoration: InputDecoration(
                      labelText: "Select Departure City",
                      contentPadding: EdgeInsets.symmetric(horizontal: 12),
                      border: OutlineInputBorder(),
                    ),
                  ),
                  popupProps: PopupProps.menu(
                    showSearchBox: true,
                    searchFieldProps: TextFieldProps(
                      decoration: InputDecoration(
                        hintText: 'Search for a city...',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  clearButtonProps: ClearButtonProps(
                    // Make sure this is set to true
                    isVisible: _selectedDepartureCityId != null,
                    icon: Icon(Icons.clear),
                    onPressed: () {
                      setState(() {
                        _selectedDepartureCityId =
                            null; // Reset the selected value
                        _fetchRides(); // Fetch all results
                      });
                    },
                  ),
                  selectedItem: locations.firstWhere(
                    (location) =>
                        location.locationId == _selectedDepartureCityId,
                    orElse: () => Location.defaultPlaceholder(),
                  ),
                );
              },
            ),
          ),
          SizedBox(width: 10),
          Expanded(
            child: FutureBuilder<SearchResult<Location>>(
              future: _locationsFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text('Error loading locations');
                } else if (!snapshot.hasData || snapshot.data!.result.isEmpty) {
                  return Text('No locations available');
                }

                final locations = snapshot.data!.result;

                return DropdownSearch<Location>(
                  items: locations,
                  itemAsString: (Location loc) => loc.city,
                  onChanged: (Location? newValue) {
                    setState(() {
                      _selectedDestinationCityId = newValue?.locationId;
                      _currentPage = 1;
                      _fetchRides();
                    });
                  },
                  dropdownDecoratorProps: DropDownDecoratorProps(
                    dropdownSearchDecoration: InputDecoration(
                      labelText: "Select Destination City",
                      contentPadding: EdgeInsets.symmetric(horizontal: 12),
                      border: OutlineInputBorder(),
                    ),
                  ),
                  popupProps: PopupProps.menu(
                    showSearchBox: true,
                    searchFieldProps: TextFieldProps(
                      decoration: InputDecoration(
                        hintText: 'Search for a city...',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  clearButtonProps: ClearButtonProps(
                    // Make sure this is set to true
                    isVisible: _selectedDestinationCityId != null,
                    icon: Icon(Icons.clear),
                    onPressed: () {
                      setState(() {
                        _selectedDestinationCityId =
                            null; // Reset the selected value
                        _fetchRides(); // Fetch all results
                      });
                    },
                  ),
                  selectedItem: locations.firstWhere(
                    (location) =>
                        location.locationId == _selectedDestinationCityId,
                    orElse: () => Location.defaultPlaceholder(),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
