import 'package:flutter/material.dart';

class DropDown extends StatelessWidget {
  final Function onSelect;
  final List<Map<String, String>> cities;

  DropDown(this.onSelect, this.cities);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: DropdownButton(
        hint: Text(
          'Your City',
          style: TextStyle(color: Colors.white),
        ),
        iconEnabledColor: Colors.white,
        items: cities
            .map(
              (item) => new DropdownMenuItem(
                value: item['id'],
                child: Text("${item['name']}", softWrap: true),
              ),
            )
            .toList(),
        onChanged: (val) {
          onSelect(val);
        },
      ),
    );
  }
}
