import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CopyOnLongPressWidget extends StatelessWidget {
  final String text;

  const CopyOnLongPressWidget({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: () {
        // Copy the text to the clipboard
        Clipboard.setData(ClipboardData(text: text));

        // Show a snackbar to indicate that the text has been copied
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Text copied to clipboard'),
            duration: Duration(seconds: 2),
          ),
        );
      },
      child: Text(
        text,
        style: TextStyle(
          color: Colors.blue,
          decoration: TextDecoration.underline,
        ),
      ),
    );
  }
}