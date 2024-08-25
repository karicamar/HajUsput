import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:hajusput_mobile/providers/user_provider.dart';

class UsernamePasswordScreen extends StatefulWidget {
  final String email;
  final String firstName;
  final String lastName;
  final int genderId;
  final String? phoneNumber;

  UsernamePasswordScreen({
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.genderId,
    this.phoneNumber,
  });

  @override
  _UsernamePasswordScreenState createState() => _UsernamePasswordScreenState();
}

class _UsernamePasswordScreenState extends State<UsernamePasswordScreen> {
  final _formKey = GlobalKey<FormBuilderState>();
  final UserProvider _userProvider = UserProvider();
  bool _isLoading = false;
  String? _errorMessage;

  void _register() async {
    if (_formKey.currentState?.saveAndValidate() ?? false) {
      setState(() {
        _isLoading = true;
        _errorMessage = null;
      });

      final formData = _formKey.currentState?.value;
      try {
        bool exists = await _userProvider.checkUsername(formData?['username']);
        if (exists) {
          setState(() {
            _errorMessage = 'Username is already in use.';
          });
        } else {
          final user = {
            'firstName': widget.firstName,
            'lastName': widget.lastName,
            'email': widget.email,
            'phoneNumber': widget.phoneNumber,
            'genderId': widget.genderId,
            'username': formData?['username'],
            'password': formData?['password'],
          };

          await _userProvider.insert(user);
          await _userProvider.login(
              formData?['username'], formData?['password']);

          Navigator.pushReplacementNamed(context, '/search');
        }
      } catch (error) {
        setState(() {
          _errorMessage = error.toString();
        });
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Username and Password'),
        backgroundColor: Colors.green.shade300,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.white,
              Colors.green.shade300,
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: FormBuilder(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'Please set up your username and password:',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.blueGrey.shade700,
                  ),
                ),
                SizedBox(height: 20),
                FormBuilderTextField(
                  name: 'username',
                  decoration: InputDecoration(
                    labelText: 'Username',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    prefixIcon: Icon(Icons.person, color: Colors.blue),
                  ),
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(
                        errorText: 'Please enter a username'),
                    FormBuilderValidators.minLength(4,
                        errorText: 'Username must be at least 4 characters'),
                  ]),
                ),
                SizedBox(height: 16.0),
                FormBuilderTextField(
                  name: 'password',
                  decoration: InputDecoration(
                    labelText: 'Password',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    prefixIcon: Icon(Icons.lock, color: Colors.blue),
                  ),
                  obscureText: true,
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(
                        errorText: 'Please enter a password'),
                    FormBuilderValidators.minLength(6,
                        errorText: 'Password must be at least 6 characters'),
                  ]),
                ),
                SizedBox(height: 20),
                if (_isLoading) Center(child: CircularProgressIndicator()),
                if (_errorMessage != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: Text(
                      _errorMessage!,
                      style: TextStyle(color: Colors.red, fontSize: 16),
                      textAlign: TextAlign.center,
                    ),
                  ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _isLoading ? null : _register,
                  style: ElevatedButton.styleFrom(
                    elevation: 6,
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.green,
                    padding: EdgeInsets.symmetric(vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                  ),
                  child: Text(
                    'Register',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
