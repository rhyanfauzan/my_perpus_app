import 'package:flutter/material.dart';
import 'package:my_perpus/helper/color_palette.dart';
import 'package:my_perpus/helper/constants.dart';

class SmallButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool invert;
  final bool disabled;

  const SmallButton(
      {Key? key, this.onPressed, required this.text, this.invert = false,this.disabled=false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: double.infinity,
        margin: EdgeInsets.symmetric(vertical: 15.0),
        padding: EdgeInsets.all(5),
        alignment: Alignment.center,
        decoration: kRoundedContainer.copyWith(
            color: invert
                ? ColorPalette.generalWhite
                : ColorPalette.generalPrimaryColor,
            borderRadius: BorderRadius.circular(15)),
        child: Text(
          text,
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
          style: TextStyle(
            color: invert
                ? ColorPalette.generalPrimaryColor
                : ColorPalette.generalBackgroundColor,
          ),
        ),
      ),
    );
  }
}
