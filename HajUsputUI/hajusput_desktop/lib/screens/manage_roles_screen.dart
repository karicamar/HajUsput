import 'package:flutter/material.dart';
import 'package:hajusput_desktop/models/role.dart';
import 'package:hajusput_desktop/providers/role_provider.dart';
import 'package:hajusput_desktop/widgets/master_screen.dart';

class ManageRolesScreen extends StatefulWidget {
  @override
  _ManageRolesScreenState createState() => _ManageRolesScreenState();
}

class _ManageRolesScreenState extends State<ManageRolesScreen> {
  late RoleProvider _roleProvider;
  List<Role> _roles = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _roleProvider = RoleProvider();
    _fetchRoles();
  }

  Future<void> _fetchRoles() async {
    try {
      var result = await _roleProvider.get();
      setState(() {
        _roles = result.result;
        _isLoading = false;
      });
    } catch (e) {
      print("Error fetching roles: $e");
      setState(() => _isLoading = false);
    }
  }

  void _showRoleDialog({Role? role}) {
    final formKey = GlobalKey<FormState>();
    final TextEditingController _nameController =
        TextEditingController(text: role?.roleName ?? "");

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(role == null ? "Add Role" : "Edit Role"),
          content: Form(
            key: formKey,
            child: TextFormField(
              controller: _nameController,
              decoration: InputDecoration(labelText: "Role Name"),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Role name cannot be empty";
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
                    if (role == null) {
                      await _roleProvider
                          .insert({"roleName": _nameController.text});
                    } else {
                      await _roleProvider.update(
                          role.roleId!, {"roleName": _nameController.text});
                    }
                    _fetchRoles();
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

  Future<void> _deleteRole(int id) async {
    try {
      await _roleProvider.delete(id);
      _fetchRoles();
    } catch (e) {
      print("Error deleting role: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return MasterScreen(
      title: "Manage Roles",
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () => _showRoleDialog(),
              child: Text("Add Role"),
            ),
            SizedBox(height: 20),
            Expanded(
              child: _isLoading
                  ? Center(child: CircularProgressIndicator())
                  : ListView.builder(
                      itemCount: _roles.length,
                      itemBuilder: (context, index) {
                        final role = _roles[index];
                        return Card(
                          child: ListTile(
                            title: Text(role.roleName),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  icon: Icon(Icons.edit, color: Colors.blue),
                                  onPressed: () => _showRoleDialog(role: role),
                                ),
                                IconButton(
                                  icon: Icon(Icons.delete, color: Colors.red),
                                  onPressed: () => _deleteRole(role.roleId!),
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
