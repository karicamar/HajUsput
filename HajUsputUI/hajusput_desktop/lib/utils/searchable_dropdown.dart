import 'package:flutter/material.dart';
import 'package:hajusput_desktop/models/location.dart';

class SearchableDropdown extends StatefulWidget {
  final List<Location> items;
  final int? selectedItem;
  final ValueChanged<int?> onChanged;
  final String hintText;

  SearchableDropdown({
    required this.items,
    this.selectedItem,
    required this.onChanged,
    required this.hintText,
  });

  @override
  _SearchableDropdownState createState() => _SearchableDropdownState();
}

class _SearchableDropdownState extends State<SearchableDropdown> {
  TextEditingController _controller = TextEditingController();
  List<Location> _filteredItems = [];

  @override
  void initState() {
    super.initState();
    _filteredItems = widget.items;
  }

  void _filterItems(String query) {
    setState(() {
      _filteredItems = widget.items
          .where(
              (item) => item.city.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextField(
          controller: _controller,
          decoration: InputDecoration(
            hintText: widget.hintText,
            prefixIcon: Icon(Icons.search),
          ),
          onChanged: _filterItems,
        ),
        DropdownButton<int>(
          hint: Text(widget.hintText),
          value: widget.selectedItem,
          isExpanded: true,
          onChanged: (int? newValue) {
            widget.onChanged(newValue);
          },
          items: _filteredItems.map((location) {
            return DropdownMenuItem<int>(
              value: location.locationId,
              child: Text(location.city),
            );
          }).toList(),
        ),
      ],
    );
  }
}
