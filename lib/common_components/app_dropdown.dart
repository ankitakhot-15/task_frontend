import 'package:flutter/material.dart';
import 'app_input_decoration.dart';

class AppDropdown extends StatelessWidget {
  final String label;
  final String? value;
  final List<Map> items;
  final Function(String?) onChanged;

  const AppDropdown({
    super.key,
    required this.label,
    required this.value,
    required this.items,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: DropdownButtonFormField<String>(
        value: value,
        items: items.map((item) {
          return DropdownMenuItem<String>(
            value: item['_id'],
            child: Text(item['name']),
          );
        }).toList(),
        onChanged: onChanged,
        decoration: appInputDecoration(label),
        validator: (val) => val == null ? "Select $label" : null,
      ),
    );
  }
}