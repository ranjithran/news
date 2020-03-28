import 'package:flutter/material.dart';

class Topicsbutton extends StatelessWidget {
  final String text;

  const Topicsbutton({Key key, this.text}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Tab(
      text: text,
    );
  }
}
