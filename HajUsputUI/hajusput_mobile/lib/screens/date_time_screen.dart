import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:hajusput_mobile/models/ride.dart';
import 'package:hajusput_mobile/providers/ride_provider.dart';
import 'package:hajusput_mobile/screens/seat_selection_screen.dart';
import 'package:provider/provider.dart';

class DateTimeScreen extends StatefulWidget {
  final Ride ride;

  DateTimeScreen({
    required this.ride,
  });

  @override
  _DateTimeScreenState createState() => _DateTimeScreenState();
}

class _DateTimeScreenState extends State<DateTimeScreen> {
  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    // Ensure the loading state is reset when the screen is initialized
    _isLoading = false;
  }

  Future<void> _selectTime(BuildContext context) async {
    final pickedTime = await showTimePicker(
      context: context,
      initialTime: _selectedTime ?? TimeOfDay.now(),
      builder: (BuildContext context, Widget? child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
          child: child!,
        );
      },
    );

    if (pickedTime != null) {
      setState(() {
        _selectedTime = pickedTime;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select Date and Time'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (_selectedDate == null) ...[
                  Text(
                    "When are you going?",
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  SizedBox(height: 16.0),
                  CalendarDatePicker(
                    initialDate: DateTime.now(),
                    firstDate: DateTime.now(),
                    lastDate: DateTime(2101),
                    onDateChanged: (DateTime date) {
                      setState(() {
                        _selectedDate = date;
                      });
                    },
                  ),
                ] else ...[
                  Text(
                    "What is the pick-up time?",
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  SizedBox(height: 16.0),
                  GestureDetector(
                    onTap: () => _selectTime(context),
                    child: Container(
                      padding: EdgeInsets.symmetric(
                          vertical: 16.0, horizontal: 24.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            _selectedTime != null
                                ? DateFormat.Hm().format(DateTime(0, 0, 0,
                                    _selectedTime!.hour, _selectedTime!.minute))
                                : 'Select Time',
                            style: TextStyle(fontSize: 18.0),
                          ),
                          Icon(Icons.access_time, color: Colors.grey),
                        ],
                      ),
                    ),
                  ),
                ],
              ],
            ),
            if (_isLoading)
              Center(
                child: CircularProgressIndicator(),
              ),
          ],
        ),
      ),
      floatingActionButton: !_isLoading &&
              _selectedDate != null &&
              _selectedTime != null
          ? FloatingActionButton(
              onPressed: () async {
                setState(() {
                  _isLoading =
                      true; // Show the loader and hide the button when pressed
                });

                final selectedDateTime = DateTime(
                  _selectedDate!.year,
                  _selectedDate!.month,
                  _selectedDate!.day,
                  _selectedTime!.hour,
                  _selectedTime!.minute,
                );

                widget.ride.departureDate = selectedDateTime;

                if (widget.ride.rideId == null) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SeatSelectionScreen(
                        ride: widget.ride,
                      ),
                    ),
                  ).then((_) {
                    setState(() {
                      _isLoading =
                          false; // Reset loading state when coming back
                    });
                  });
                } else {
                  try {
                    final rideProvider =
                        Provider.of<RideProvider>(context, listen: false);

                    await rideProvider.update(widget.ride.rideId!, widget.ride);

                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Ride updated successfully!')),
                    );

                    Navigator.pop(context, widget.ride.departureDate);
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                          content:
                              Text('Failed to update ride. Please try again.')),
                    );
                  } finally {
                    setState(() {
                      _isLoading = false; // Hide the loader after the process
                    });
                  }
                }
              },
              child: Icon(Icons.check),
              tooltip: 'Confirm Date and Time',
            )
          : null,
    );
  }
}
