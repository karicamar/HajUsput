import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:hajusput_mobile/models/user.dart';
import 'package:hajusput_mobile/providers/user_provider.dart';
import 'package:provider/provider.dart';

class EditDetailsScreen extends StatefulWidget {
  final User user;

  const EditDetailsScreen({super.key, required this.user});

  @override
  _EditDetailsScreenState createState() => _EditDetailsScreenState();
}

class _EditDetailsScreenState extends State<EditDetailsScreen> {
  final _formKey = GlobalKey<FormBuilderState>();

  Future<void> _saveDetails() async {
    if (_formKey.currentState!.saveAndValidate()) {
      final userProvider = Provider.of<UserProvider>(context, listen: false);

      try {
        final formValues = _formKey.currentState!.value;
        widget.user.firstName = formValues['firstName'];
        widget.user.lastName = formValues['lastName'];
        widget.user.email = formValues['email'];
        widget.user.phoneNumber = formValues['phoneNumber'];

        await userProvider.update(widget.user.userId!, widget.user);

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Details updated successfully!')),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to update details: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Details'),
        backgroundColor: Colors.green.shade300,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 5,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: FormBuilder(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildFormTextField(
                    name: 'firstName',
                    label: 'First Name',
                    initialValue: widget.user.firstName,
                    validators: [FormBuilderValidators.required()],
                  ),
                  SizedBox(height: 20),
                  _buildFormTextField(
                    name: 'lastName',
                    label: 'Last Name',
                    initialValue: widget.user.lastName,
                    validators: [FormBuilderValidators.required()],
                  ),
                  SizedBox(height: 20),
                  _buildFormTextField(
                    name: 'email',
                    label: 'Email',
                    initialValue: widget.user.email,
                    validators: [
                      FormBuilderValidators.required(),
                      FormBuilderValidators.email(),
                    ],
                  ),
                  SizedBox(height: 20),
                  _buildFormTextField(
                    name: 'phoneNumber',
                    label: 'Phone Number',
                    initialValue: widget.user.phoneNumber ?? '',
                  ),
                  SizedBox(height: 30),
                  Center(
                    child: ElevatedButton(
                      onPressed: _saveDetails,
                      style: ElevatedButton.styleFrom(
                        padding:
                            EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                        backgroundColor: Colors.green.shade300,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: Text(
                        'Save',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFormTextField({
    required String name,
    required String label,
    required String initialValue,
    List<String? Function(String?)>? validators,
  }) {
    return FormBuilderTextField(
      name: name,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(fontSize: 16, color: Colors.teal),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      initialValue: initialValue,
      validator: FormBuilderValidators.compose(validators ?? []),
    );
  }
}
