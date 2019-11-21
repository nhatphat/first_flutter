import 'package:flutter/material.dart';
import './custom/custom.dart';

void main() => runApp(MyDemo());

class MyDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Demo Flutter',
      home: RandomWords(),
    );
  }
}

