import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:google_places_flutter/google_places_flutter.dart';
import 'package:google_places_flutter/model/prediction.dart';
import 'package:hajusput_mobile/screens/results_screen.dart';
import 'package:hajusput_mobile/utils/utils.dart';
import 'package:hajusput_mobile/widgets/master_screen.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final _formKey = GlobalKey<FormBuilderState>();
  //int _numberOfSeats = 1;
  final TextEditingController _leavingFromController = TextEditingController();
  final TextEditingController _goingToController = TextEditingController();
  final String googleApiKey = googleMapsApi; // Replace with your Google API key
  final FocusNode _leavingFromFocusNode = FocusNode();
  final FocusNode _goingToFocusNode = FocusNode();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2030),
    );
    if (picked != null) {
      final formattedDate = DateFormat.yMd().format(picked);
      _formKey.currentState!.fields['date']?.didChange(formattedDate);
    }
  }

  void _searchRides() {
    final data = _formKey.currentState!.value;
    final date = data['date'] ?? 'No date selected';

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ResultsScreen(
          leavingFrom: _leavingFromController.text,
          goingTo: _goingToController.text,
          date: date,
        ),
      ),
    );
  }

  void _switchLocations() {
    setState(() {
      final temp = _leavingFromController.text;
      _leavingFromController.text = _goingToController.text;
      _goingToController.text = temp;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _leavingFromFocusNode.unfocus();
        _goingToFocusNode.unfocus();
      },
      child: MasterScreen(
        content: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/back-car.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.8,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.95),
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 10,
                        offset: Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: FormBuilder(
                      key: _formKey,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          placesAutoCompleteTextField(
                            controller: _leavingFromController,
                            fieldName: 'leaving_from',
                            hintText: 'Leaving from',
                            focusNode: _leavingFromFocusNode,
                          ),
                          //SizedBox(height: 4),
                          IconButton(
                            icon: Icon(Icons.swap_vert),
                            onPressed: _switchLocations,
                          ),
                          //SizedBox(height: 4),
                          placesAutoCompleteTextField(
                            controller: _goingToController,
                            fieldName: 'going_to',
                            hintText: 'Going to',
                            focusNode: _goingToFocusNode,
                          ),
                          SizedBox(height: 20),
                          FormBuilderTextField(
                            name: 'date',
                            readOnly: true,
                            decoration: InputDecoration(
                              labelText: 'Date',
                              border: OutlineInputBorder(),
                              suffixIcon: IconButton(
                                icon: Icon(Icons.calendar_today),
                                onPressed: () => _selectDate(context),
                              ),
                            ),
                          ),
                          SizedBox(height: 32),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 50, vertical: 16),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                              foregroundColor: Colors.white,
                              backgroundColor: Colors.green.shade300,
                            ),
                            onPressed: () {
                              if (_formKey.currentState?.saveAndValidate() ??
                                  false) {
                                _searchRides();
                              } else {
                                print('Validation failed');
                              }
                            },
                            child: Text('Search'),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        currentIndex: 0,
      ),
    );
  }

  Widget placesAutoCompleteTextField({
    required TextEditingController controller,
    required String fieldName,
    required String hintText,
    required FocusNode focusNode,
  }) {
    return FormBuilderField(
      name: fieldName,
      builder: (FormFieldState<String?> field) {
        return GooglePlaceAutoCompleteTextField(
          textEditingController: controller,
          googleAPIKey: googleApiKey,
          focusNode: focusNode,
          inputDecoration: InputDecoration(
            hintText: hintText,
            border: OutlineInputBorder(),
            contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
          ),
          debounceTime: 400,
          countries: const ["de", "ba"],
          isLatLngRequired: true,
          getPlaceDetailWithLatLng: (Prediction prediction) {
            _moveToPlace(prediction, field, controller);
          },
          itemClick: (Prediction prediction) {
            _moveToPlace(prediction, field, controller);
            FocusScope.of(context).unfocus();
          },
          isCrossBtnShown: true,
          seperatedBuilder: Divider(),
        );
      },
    );
  }

  Future<void> _moveToPlace(Prediction prediction,
      FormFieldState<String?> field, TextEditingController controller) async {
    if (prediction.placeId != null) {
      final placeDetailsUrl =
          'https://maps.googleapis.com/maps/api/place/details/json?place_id=${prediction.placeId}&key=$googleApiKey';
      final response = await http.get(Uri.parse(placeDetailsUrl));

      if (response.statusCode == 200) {
        setState(() {
          final descriptionParts = prediction.description?.split(',') ?? [];
          final cityName =
              descriptionParts.isNotEmpty ? descriptionParts[0] : '';

          field.didChange(cityName);
          controller.text = cityName;
        });
      } else {
        throw Exception('Failed to load place details');
      }
    }
  }
}
