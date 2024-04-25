import 'dart:js';

import 'package:flutter/material.dart';

dialogBox(BuildContext context, String message) {
  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
          title: Text("error occur"),
          content: Text(message),
        );
      });
}
