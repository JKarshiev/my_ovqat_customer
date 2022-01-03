import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
// In this widget it warns the user about error if it happens
// during registration or sign in
class ErrorDialog extends StatelessWidget {

  final String? message;
  ErrorDialog({this.message});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      key: key,
      content: Text(message!),
      actions: [
        ElevatedButton(
          child: Center(
            child: Text("OK"),
          ),
          style: ElevatedButton.styleFrom(
            primary: Colors.red,
          ),
          onPressed: (){
            Navigator.pop(context);
          },
        ),
      ],
    );
  }
}
