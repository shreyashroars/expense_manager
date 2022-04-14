import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class AdaptiveTextButton extends StatelessWidget {
  final VoidCallback handler;
  AdaptiveTextButton(this.handler);
  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? CupertinoButton(
            child: const Text(
              'Choose Date',
              style:
                  TextStyle(color: Colors.purple, fontWeight: FontWeight.bold),
            ),
            onPressed: handler,
          )
        : TextButton(
            child: const Text(
              'Choose Date',
              style:
                  TextStyle(color: Colors.purple, fontWeight: FontWeight.bold),
            ),
            onPressed: handler,
          );
  }
}
