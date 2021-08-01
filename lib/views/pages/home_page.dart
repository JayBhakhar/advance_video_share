import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  List mainPageList = [1, 2, 3, 4, 5, 6, 7, 8];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView.builder(
          itemCount: mainPageList.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(mainPageList[index]),
            );
          },
        ),
      ),
    );
  }
}
