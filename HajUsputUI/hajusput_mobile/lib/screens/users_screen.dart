import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:hajusput_mobile/models/gender.dart';
import 'package:hajusput_mobile/providers/gender_provider.dart';
import 'package:provider/provider.dart';
import 'package:hajusput_mobile/models/search_result.dart';
import 'package:hajusput_mobile/models/user.dart';
import 'package:hajusput_mobile/providers/user_provider.dart';
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
    result = await _userProvider.get(filter: {'fts': _controller.text});
    genderResult = await _genderProvider.get();
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [_buildSearch(), _buildDataListView()],
      ),
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
                style: TextStyle(fontStyle: FontStyle.italic),
              ),
            ),
            DataColumn(
              label: Text(
                'Surname',
                style: TextStyle(fontStyle: FontStyle.italic),
              ),
            ),
            DataColumn(
              label: Text(
                'Email',
                style: TextStyle(fontStyle: FontStyle.italic),
              ),
            ),
            DataColumn(
              label: Text(
                'Phone number',
                style: TextStyle(fontStyle: FontStyle.italic),
              ),
            ),
          ],
          rows: result?.result
                  .map((User e) => DataRow(
                        onSelectChanged: (selected) {
                          if (selected == true) {
                            _dialogBuilder(context, e);
                          }
                        },
                        cells: [
                          DataCell(Text(e.firstName ?? "")),
                          DataCell(Text(e.lastName ?? "")),
                          DataCell(Text(e.email)),
                          DataCell(Text(e.phoneNumber ?? "")),
                        ],
                      ))
                  .toList() ??
              [],
        ),
      ),
    );
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
                                  child: Text(item.genderName ?? ""),
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
              child: Text('Cancel'),
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
    } on Exception catch (e) {
      showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: Text("Error"),
          content: Text(e.toString()),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text("OK"),
            ),
          ],
        ),
      );
    }
  }

  Widget _buildSearch() {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Row(
        children: [
          SizedBox(
            width: 400,
            child: TextField(
              controller: _controller,
              decoration: InputDecoration(
                labelText: "Search",
                prefixIcon: Icon(Icons.search),
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
}
