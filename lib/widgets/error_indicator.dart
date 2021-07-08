import 'package:flutter/material.dart';

class ErrorIndicator extends StatelessWidget {
  final String text;
  final Function onPressed;
  const ErrorIndicator({
    Key key,
    @required this.text,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.only(bottom: 16),
            child: Text(text),
          ),
          if (onPressed != null)
            ElevatedButton(
              onPressed: onPressed,
              child: Text('Try again'),
            ),
        ],
      ),
    );
  }
}
