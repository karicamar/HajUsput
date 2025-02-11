import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:hajusput_desktop/models/gender.dart';
import 'package:hajusput_desktop/models/role.dart';
import 'package:hajusput_desktop/providers/gender_provider.dart';
import 'package:hajusput_desktop/providers/role_provider.dart';
import 'package:hajusput_desktop/providers/user_role_provider.dart';
import 'package:provider/provider.dart';
import 'package:hajusput_desktop/models/search_result.dart';
import 'package:hajusput_desktop/models/user.dart';
import 'package:hajusput_desktop/providers/user_provider.dart';
import '../widgets/master_screen.dart';

class UsersScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MasterScreen(
      title: 'Users',
      body: UsersBody(),
    );
  }
}

class UsersBody extends StatefulWidget {
  @override
  _UsersBodyState createState() => _UsersBodyState();
}

class _UsersBodyState extends State<UsersBody> {
  final _formKey = GlobalKey<FormBuilderState>();
  late UserProvider _userProvider;
  late GenderProvider _genderProvider;
  bool _includeBlockedUsers = false;
  SearchResult<User>? result;
  SearchResult<Gender>? genderResult;

  TextEditingController _controller = TextEditingController();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _userProvider = context.read<UserProvider>();
    _genderProvider = context.read<GenderProvider>();
    _asyncMethod();
  }

  Future<void> _asyncMethod() async {
    result = await _userProvider.get(filter: {
      'fts': _controller.text,
      'isBlocked': _includeBlockedUsers ? null : false,
      'IsRoleIncluded': true
    });

    genderResult = await _genderProvider.get();
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          _buildSearch(),
          SizedBox(height: 10),
          _buildIncludeBlockedCheckbox(),
          SizedBox(height: 20),
          _buildDataListView(),
        ],
      ),
    );
  }

  Widget _buildSearch() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _controller,
              decoration: InputDecoration(
                labelText: "Search users",
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onChanged: (String value) {
                _asyncMethod();
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildIncludeBlockedCheckbox() {
    return Row(
      children: [
        Checkbox(
          value: _includeBlockedUsers,
          onChanged: (bool? value) {
            setState(() {
              _includeBlockedUsers = value ?? false;
            });
            _asyncMethod();
          },
        ),
        Text("Include Blocked Users"),
      ],
    );
  }

  Widget _buildDataListView() {
    return Expanded(
      child: SingleChildScrollView(
        child: DataTable(
          showCheckboxColumn: false,
          columns: [
            DataColumn(
              label: Text(
                'Name',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            DataColumn(
              label: Text(
                'Surname',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            DataColumn(
              label: Text(
                'Email',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            DataColumn(
              label: Text(
                'Phone Number',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            DataColumn(
              label: Text(
                'Actions',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ],
          rows: result?.result
                  .map((User user) => DataRow(
                        onSelectChanged: (selected) {
                          if (selected == true) {
                            _dialogBuilder(context, user);
                          }
                        },
                        cells: [
                          DataCell(Text(user.firstName!)),
                          DataCell(Text(user.lastName!)),
                          DataCell(Text(user.email!)),
                          DataCell(Text(user.phoneNumber ?? "")),
                          DataCell(_buildActionsColumn(user)),
                        ],
                      ))
                  .toList() ??
              [],
        ),
      ),
    );
  }

  Widget _buildActionsColumn(User user) {
    return Row(
      children: [
        IconButton(
          icon: Icon(Icons.info, color: Colors.blue),
          onPressed: () {
            _showRoleDialog(user: user);
          },
        ),
        IconButton(
          icon: Icon(
            user.isBlocked == true ? Icons.lock_open : Icons.block,
            color: user.isBlocked == true ? Colors.green[900] : Colors.red,
          ),
          onPressed: () {
            _confirmBlockUser(context, user);
          },
        ),
      ],
    );
  }

  Future<void> _showRoleDialog({User? user}) async {
    if (user == null) return;

    final _formKey = GlobalKey<FormState>();
    List<Role> _roles = [];
    Role? _selectedRole;
    UserRoleProvider userRoleProvider = UserRoleProvider();

    try {
      var roleProvider = RoleProvider();
      var result = await roleProvider.get();
      _roles = result.result;

      print("User Role ID: ${user.userRoles.first.roleId}");
      print("Available Roles: ${_roles.map((r) => r.roleId).toList()}");

      _selectedRole = _roles.firstWhere(
        (role) => role.roleId == user.userRoles.first.roleId,
        orElse: () => _roles.first,
      );
    } catch (e) {
      print("Error fetching roles: $e");
      return;
    }

    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Change User Role"),
          content: Form(
            key: _formKey,
            child: DropdownButtonFormField<Role>(
              value: _selectedRole,
              decoration: InputDecoration(labelText: "Select Role"),
              items: _roles.map((role) {
                return DropdownMenuItem<Role>(
                  value: role,
                  child: Text(role.roleName),
                );
              }).toList(),
              onChanged: (value) {
                _selectedRole = value;
              },
              validator: (value) =>
                  value == null ? "Please select a role" : null,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () async {
                if (_formKey.currentState!.validate() &&
                    _selectedRole != null) {
                  try {
                    int? userRoleId = user.userRoles.first.userRoleId;
                    Map<String, dynamic> updateRequest = {
                      "userId": user.userId,
                      "roleId": _selectedRole!.roleId,
                    };
                    await userRoleProvider.update(userRoleId!, updateRequest);

                    _asyncMethod(); // Refresh the user list
                    Navigator.pop(context);
                    print("User role updated successfully");
                  } catch (e) {
                    print("Error updating role: $e");
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

  Future<void> _confirmBlockUser(BuildContext context, User user) async {
    final isBlocking = !user.isBlocked!; // Determine the action

    final result = await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(isBlocking ? 'Block User' : 'Unblock User'),
          content: Text(isBlocking
              ? 'Are you sure you want to block this user?'
              : 'Are you sure you want to unblock this user?'),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel', style: TextStyle(color: Colors.black)),
              onPressed: () {
                Navigator.of(context).pop(false);
              },
            ),
            ElevatedButton(
              child: Text(isBlocking ? 'Block' : 'Unblock',
                  style:
                      TextStyle(color: isBlocking ? Colors.red : Colors.green)),
              onPressed: () {
                Navigator.of(context).pop(true);
              },
            ),
          ],
        );
      },
    );

    if (result == true) {
      await _toggleBlockUser(user);
    }
  }

  Future<void> _toggleBlockUser(User user) async {
    try {
      if (user.isBlocked == true) {
        // Unblock the user
        await _userProvider.blockUser(user.userId!);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content:
              Text('${user.firstName} ${user.lastName} has been unblocked.'),
        ));
      } else {
        // Block the user
        await _userProvider.blockUser(user.userId!);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('${user.firstName} ${user.lastName} has been blocked.'),
        ));
      }
      _asyncMethod();
    } catch (e) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Error'),
          content: Text('Failed to update user status: $e'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  Future<void> _dialogBuilder(BuildContext context, User user) async {
    final result = await showDialog<Map<String, dynamic>>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Edit User'),
          content: SingleChildScrollView(
            child: FormBuilder(
              key: _formKey,
              initialValue: {
                'firstName': user.firstName,
                'lastName': user.lastName,
                'email': user.email,
                'phoneNumber': user.phoneNumber,
                'genderId': user.genderId.toString(),
              },
              child: Column(
                children: <Widget>[
                  FormBuilderTextField(
                    name: 'firstName',
                    decoration: InputDecoration(labelText: 'Name'),
                  ),
                  FormBuilderTextField(
                    name: 'lastName',
                    decoration: InputDecoration(labelText: 'Last Name'),
                  ),
                  FormBuilderTextField(
                    name: 'email',
                    decoration: InputDecoration(labelText: 'Email'),
                  ),
                  FormBuilderTextField(
                    name: 'phoneNumber',
                    decoration: InputDecoration(labelText: 'Phone Number'),
                  ),
                  FormBuilderDropdown<String>(
                    name: 'genderId',
                    decoration: InputDecoration(
                      labelText: 'Gender',
                      suffix: IconButton(
                        icon: const Icon(Icons.close),
                        onPressed: () {
                          _formKey.currentState!.fields['genderId']?.reset();
                        },
                      ),
                      hintText: 'Select Gender',
                    ),
                    items: genderResult?.result
                            .map((item) => DropdownMenuItem(
                                  alignment: AlignmentDirectional.center,
                                  value: item.genderId.toString(),
                                  child: Text(item.genderName),
                                ))
                            .toList() ??
                        [],
                  ),
                ],
              ),
            ),
          ),
          actions: <Widget>[
            ElevatedButton(
              child: Text('Submit'),
              onPressed: () {
                if (_formKey.currentState?.saveAndValidate() ?? false) {
                  Navigator.of(context).pop(_formKey.currentState?.value);
                } else {
                  print("Validation failed");
                }
              },
            ),
            ElevatedButton(
              child: Text('Cancel', style: TextStyle(color: Colors.black)),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );

    if (result != null) {
      _handleFormSubmission(user.userId, result);
    }
  }

  Future<void> _handleFormSubmission(
      int? userId, Map<String, dynamic> formData) async {
    var request = Map<String, dynamic>.from(formData);
    try {
      if (userId == null) {
        await _userProvider.insert(request);
      } else {
        await _userProvider.update(userId, request);
      }
      _asyncMethod();
    } catch (e) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Error'),
          content: Text('Failed to save user: $e'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('OK'),
            ),
          ],
        ),
      );
    }
  }
}
