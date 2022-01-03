import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:my_ovqat_customer/widgets/progress_bar.dart';

// In this widget it warns the user about error if it happens
// during registration or sign in
class LoadingDialog extends StatelessWidget {

  final String? message;
  LoadingDialog({this.message});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      key: key,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          circularProgress(),
          SizedBox(height: 10,),
          Text(message! + " Please wait...")
        ],
      ),
    );
  }
}