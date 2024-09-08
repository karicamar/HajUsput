import 'package:flutter/material.dart';
import 'package:hajusput_mobile/models/car.dart';
import 'package:hajusput_mobile/providers/car_provider.dart';
import 'package:provider/provider.dart';

class CarScreen extends StatefulWidget {
  final int userId;

  CarScreen({required this.userId});

  @override
  _CarScreenState createState() => _CarScreenState();
}

class _CarScreenState extends State<CarScreen> {
  Car? car;
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _fetchCarDetails();
  }

  Future<void> _fetchCarDetails() async {
    final carProvider = Provider.of<CarProvider>(context, listen: false);
    setState(() {
      _isLoading = true;
    });

    try {
      final fetchedCar = await carProvider.getByUserId(widget.userId);
      setState(() {
        car = fetchedCar;
      });
    } catch (e) {
      print('Error fetching car details: $e');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _saveCarDetails() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      try {
        final carProvider = Provider.of<CarProvider>(context, listen: false);
        if (car != null) {
          await carProvider.update(car!.carId!, car);
        } else {
          await carProvider.insert(Car(
            0,
            widget.userId,
            car!.make,
            car!.carType,
            car!.color,
            car!.yearOfManufacture,
            car!.licensePlateNumber,
          ));
        }

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Car details saved successfully!')),
        );
        Navigator.pop(context);
      } catch (e) {
        print('Error saving car details: $e');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to save car details.')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('My Car')),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 5,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildDropdownField(
                          title: 'Make',
                          value: car?.make,
                          options: ['Toyota', 'Ford', 'BMW'], // Example options
                          onSaved: (value) => car!.make = value!,
                          validator: (value) =>
                              value == null ? 'Please select car make' : null,
                        ),
                        SizedBox(height: 16),
                        _buildDropdownField(
                          title: 'Car Type',
                          value: car?.carType,
                          options: [
                            'Sedan',
                            'SUV',
                            'Hatchback'
                          ], // Example options
                          onSaved: (value) => car!.carType = value!,
                          validator: (value) =>
                              value == null ? 'Please select car type' : null,
                        ),
                        SizedBox(height: 16),
                        _buildDropdownField(
                          title: 'Color',
                          value: car?.color,
                          options: ['Red', 'Blue', 'Black'], // Example options
                          onSaved: (value) => car!.color = value!,
                          validator: (value) =>
                              value == null ? 'Please select car color' : null,
                        ),
                        SizedBox(height: 16),
                        _buildDropdownField(
                          title: 'Year of Manufacture',
                          value: car?.yearOfManufacture?.toString(),
                          options: List.generate(
                              30,
                              (index) =>
                                  (1995 + index).toString()), // Example options
                          onSaved: (value) =>
                              car!.yearOfManufacture = int.parse(value!),
                          validator: (value) => value == null
                              ? 'Please select year of manufacture'
                              : null,
                        ),
                        SizedBox(height: 16),
                        TextFormField(
                          initialValue: car?.licensePlateNumber,
                          decoration: InputDecoration(
                            labelText: 'License Plate Number (Optional)',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            filled: true,
                            fillColor: Colors.grey[200],
                          ),
                          onSaved: (value) => car!.licensePlateNumber = value!,
                        ),
                        SizedBox(height: 30),
                        Center(
                          child: ElevatedButton(
                            onPressed: _saveCarDetails,
                            style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 50, vertical: 15),
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

  Widget _buildDropdownField({
    required String title,
    String? value,
    required List<String> options,
    required FormFieldSetter<String> onSaved,
    FormFieldValidator<String>? validator,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8),
        DropdownButtonFormField<String>(
          value: value,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            filled: true,
            fillColor: Colors.grey[200],
          ),
          items: options.map((String option) {
            return DropdownMenuItem<String>(
              value: option,
              child: Text(option),
            );
          }).toList(),
          onChanged: (newValue) {
            // Handle change if needed
          },
          onSaved: onSaved,
          validator: validator,
        ),
      ],
    );
  }
}
