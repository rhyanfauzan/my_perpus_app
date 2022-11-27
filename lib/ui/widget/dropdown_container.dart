import 'package:flutter/material.dart';
import 'package:my_perpus/helper/color_palette.dart';
import 'package:my_perpus/helper/constants.dart';

class DropdownContainer extends StatelessWidget {
  const DropdownContainer({
    Key? key,
    required this.hint,
    required this.value,
    required this.onChanged,
    required this.items,
  }) : super(key: key);

  final String hint;
  final String value;
  final List<String> items;
  final Function(String?) onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      decoration: kRoundedContainer,
      child: DropdownButton(
        value: value,
        isExpanded: true,
        underline: SizedBox(),
        hint: Text(
          hint,
          style: TextStyle(color: ColorPalette.generalPrimaryColor),
        ),
        items: items.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
        onChanged: onChanged,
      ),
    );
  }
}
