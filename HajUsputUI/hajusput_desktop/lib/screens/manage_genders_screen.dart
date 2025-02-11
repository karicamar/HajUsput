import 'package:flutter/material.dart';
import 'package:hajusput_desktop/models/gender.dart';
import 'package:hajusput_desktop/providers/gender_provider.dart';
import 'package:hajusput_desktop/widgets/master_screen.dart';

class ManageGendersScreen extends StatefulWidget {
  @override
  _ManageGendersScreenState createState() => _ManageGendersScreenState();
}

class _ManageGendersScreenState extends State<ManageGendersScreen> {
  late GenderProvider _genderProvider;
  List<Gender> _genders = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _genderProvider = GenderProvider();
    _fetchGenders();
  }

  Future<void> _fetchGenders() async {
    try {
      var result = await _genderProvider.get();
      setState(() {
        _genders = result.result;
        _isLoading = false;
      });
    } catch (e) {
      print("Error fetching genders: $e");
      setState(() => _isLoading = false);
    }
  }

  void _showGenderDialog({Gender? gender}) {
    final formKey = GlobalKey<FormState>();
    final TextEditingController _nameController =
        TextEditingController(text: gender?.genderName ?? "");

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(gender == null ? "Add Gender" : "Edit Gender"),
          content: Form(
            key: formKey,
            child: TextFormField(
              controller: _nameController,
              decoration: InputDecoration(labelText: "Gender Name"),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Gender name cannot be empty";
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
                    if (gender == null) {
                      await _genderProvider
                          .insert({"name": _nameController.text});
                    } else {
                      await _genderProvider.update(
                          gender.genderId!, {"name": _nameController.text});
                    }
                    _fetchGenders();
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

  Future<void> _deleteGender(int id) async {
    try {
      await _genderProvider.delete(id);
      _fetchGenders();
    } catch (e) {
      print("Error deleting gender: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return MasterScreen(
      title: "Manage Genders",
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () => _showGenderDialog(),
              child: Text("Add Gender"),
            ),
            SizedBox(height: 20),
            Expanded(
              child: _isLoading
                  ? Center(child: CircularProgressIndicator())
                  : ListView.builder(
                      itemCount: _genders.length,
                      itemBuilder: (context, index) {
                        final gender = _genders[index];
                        return Card(
                          child: ListTile(
                            title: Text(gender.genderName),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  icon: Icon(Icons.edit, color: Colors.blue),
                                  onPressed: () =>
                                      _showGenderDialog(gender: gender),
                                ),
                                IconButton(
                                  icon: Icon(Icons.delete, color: Colors.red),
                                  onPressed: () =>
                                      _deleteGender(gender.genderId!),
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
