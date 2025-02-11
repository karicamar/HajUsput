import 'package:flutter/material.dart';
import 'package:hajusput_desktop/models/location.dart';
import 'package:hajusput_desktop/providers/location_provider.dart';
import 'package:hajusput_desktop/widgets/master_screen.dart';

class ManageLocationsScreen extends StatefulWidget {
  @override
  _ManageLocationsScreenState createState() => _ManageLocationsScreenState();
}

class _ManageLocationsScreenState extends State<ManageLocationsScreen> {
  late LocationProvider _locationProvider;
  List<Location> _locations = [];
  bool _isLoading = true;
  TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _locationProvider = LocationProvider();
    _fetchLocations();
  }

  Future<void> _fetchLocations({String? searchQuery}) async {
    try {
      var filter = searchQuery != null && searchQuery.isNotEmpty
          ? {"City": searchQuery} // Filtering by city
          : null;

      var result = await _locationProvider.get(filter: filter);
      setState(() {
        _locations = result.result;
        _isLoading = false;
      });
    } catch (e) {
      print("Error fetching locations: $e");
      setState(() => _isLoading = false);
    }
  }

  void _showLocationDialog({Location? location}) {
    final formKey = GlobalKey<FormState>();
    TextEditingController _cityController =
        TextEditingController(text: location?.city ?? "");
    TextEditingController _countryController =
        TextEditingController(text: location?.country ?? "");

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(location == null ? "Add Location" : "Edit Location"),
          content: Form(
            key: formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: _cityController,
                  decoration: InputDecoration(labelText: "City"),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "City cannot be empty";
                    }
                    return null;
                  },
                ),
                SizedBox(height: 10),
                TextFormField(
                  controller: _countryController,
                  decoration: InputDecoration(labelText: "Country"),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Country cannot be empty";
                    }
                    return null;
                  },
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () async {
                if (formKey.currentState!.validate()) {
                  try {
                    if (location == null) {
                      await _locationProvider.insert({
                        "city": _cityController.text,
                        "country": _countryController.text
                      });
                    } else {
                      await _locationProvider.update(location.locationId!, {
                        "city": _cityController.text,
                        "country": _countryController.text
                      });
                    }
                    _fetchLocations();
                    Navigator.pop(context);
                  } catch (e) {
                    print("Error: $e");
                  }
                }
              },
              child: Text("Save"),
            ),
          ],
        );
      },
    );
  }

  Future<void> _deleteLocation(int id) async {
    try {
      await _locationProvider.delete(id);
      _fetchLocations();
    } catch (e) {
      print("Error deleting location: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return MasterScreen(
      title: "Manage Locations",
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      labelText: "Search by city",
                      prefixIcon: Icon(Icons.search),
                      border: OutlineInputBorder(),
                    ),
                    onChanged: (value) {
                      _fetchLocations(searchQuery: value);
                    },
                  ),
                ),
                SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () => _showLocationDialog(),
                  child: Text("Add Location"),
                ),
              ],
            ),
            SizedBox(height: 20),
            Expanded(
              child: _isLoading
                  ? Center(child: CircularProgressIndicator())
                  : ListView.builder(
                      itemCount: _locations.length,
                      itemBuilder: (context, index) {
                        final location = _locations[index];
                        return Card(
                          child: ListTile(
                            title:
                                Text("${location.city}, ${location.country}"),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  icon: Icon(Icons.edit, color: Colors.blue),
                                  onPressed: () =>
                                      _showLocationDialog(location: location),
                                ),
                                IconButton(
                                  icon: Icon(Icons.delete, color: Colors.red),
                                  onPressed: () =>
                                      _deleteLocation(location.locationId!),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
