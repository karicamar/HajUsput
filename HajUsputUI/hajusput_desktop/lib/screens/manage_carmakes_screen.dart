import 'package:flutter/material.dart';
import 'package:hajusput_desktop/models/carMake.dart';
import 'package:hajusput_desktop/providers/carmake_provider.dart';
import 'package:hajusput_desktop/widgets/master_screen.dart';

class ManageCarMakesScreen extends StatefulWidget {
  @override
  _ManageCarMakesScreenState createState() => _ManageCarMakesScreenState();
}

class _ManageCarMakesScreenState extends State<ManageCarMakesScreen> {
  late CarMakeProvider _carMakeProvider;
  List<CarMake> _carMakes = [];
  bool _isLoading = true;
  TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _carMakeProvider = CarMakeProvider();
    _fetchCarMakes();
  }

  Future<void> _fetchCarMakes({String? searchQuery}) async {
    try {
      var filter = searchQuery != null && searchQuery.isNotEmpty
          ? {"CarMake": searchQuery}
          : null;

      var result = await _carMakeProvider.get(filter: filter);
      setState(() {
        _carMakes = result.result;
        _isLoading = false;
      });
    } catch (e) {
      print("Error fetching car makes: $e");
      setState(() => _isLoading = false);
    }
  }

  void _showCarMakeDialog({CarMake? carMake}) {
    final formKey = GlobalKey<FormState>();
    TextEditingController _nameController =
        TextEditingController(text: carMake?.carMakeName ?? "");

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(carMake == null ? "Add Car Make" : "Edit Car Make"),
          content: Form(
            key: formKey,
            child: TextFormField(
              controller: _nameController,
              decoration: InputDecoration(labelText: "Car Make Name"),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Car make name cannot be empty";
                }
                return null;
              },
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
                    if (carMake == null) {
                      await _carMakeProvider
                          .insert({"name": _nameController.text});
                    } else {
                      await _carMakeProvider.update(
                          carMake.carMakeId!, {"name": _nameController.text});
                    }
                    _fetchCarMakes();
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

  Future<void> _deleteCarMake(int id) async {
    try {
      await _carMakeProvider.delete(id);
      _fetchCarMakes();
    } catch (e) {
      print("Error deleting car make: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return MasterScreen(
      title: "Manage Car Makes",
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
                    labelText: "Search by car make",
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (value) {
                    _fetchCarMakes(searchQuery: value);
                  },
                )),
                SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () => _showCarMakeDialog(),
                  child: Text("Add Car Make"),
                ),
              ],
            ),
            SizedBox(height: 20),
            Expanded(
              child: _isLoading
                  ? Center(child: CircularProgressIndicator())
                  : ListView.builder(
                      itemCount: _carMakes.length,
                      itemBuilder: (context, index) {
                        final carMake = _carMakes[index];
                        return Card(
                          child: ListTile(
                            title: Text(carMake.carMakeName),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  icon: Icon(Icons.edit, color: Colors.blue),
                                  onPressed: () =>
                                      _showCarMakeDialog(carMake: carMake),
                                ),
                                IconButton(
                                  icon: Icon(Icons.delete, color: Colors.red),
                                  onPressed: () =>
                                      _deleteCarMake(carMake.carMakeId!),
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
