import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nengar/flavors.dart';

class NumberRecognizePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text(F.title),
      ),
      child: Center(
        child: Text(
          'Hello ${F.title}',
        ),
      ),
    );
  }
}
