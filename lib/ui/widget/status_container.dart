import 'package:flutter/material.dart';
import 'package:my_perpus/helper/color_palette.dart';
import 'package:my_perpus/helper/constants.dart';

class StatusContainer extends StatelessWidget {
  const StatusContainer({Key? key,required this.status}) : super(key: key);

  final int status;

  @override
  Widget build(BuildContext context) {
    return  Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color:backgroundStatus(status)),
      child: Text(
        checkStatus(status),
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
    );
  }
}
