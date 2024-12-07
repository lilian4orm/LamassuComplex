import 'package:flutter/material.dart';

Widget loadingDialog() {
  return AlertDialog(

    content: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        CircularProgressIndicator(),
        SizedBox(height: 16),
        Text("انتظر من فضلك..."),
      ],
    ),
  );
}