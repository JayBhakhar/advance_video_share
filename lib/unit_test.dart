import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class Test extends StatefulWidget {
  @override
  _TestState createState() => _TestState();
}

class _TestState extends State<Test> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                TextButton(
                  onPressed: () {},
                  child: Text('unit Test'),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
