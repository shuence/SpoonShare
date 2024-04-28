import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ExitConfirmationDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Exit App?'),
      content: Text('Do you want to exit the app?'),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(false); // No
          },
          child: Text('No'),
        ),
        TextButton(
          onPressed: () {
            Navigator.pop(context);
            SystemNavigator.pop();
          },
          child: Text('Yes'),
        ),
      ],
    );
  }
}
