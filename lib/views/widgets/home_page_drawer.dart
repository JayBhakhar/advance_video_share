import 'package:flutter/material.dart';

Widget homePageDrawer() {
  return SafeArea(
    child: Drawer(
      child: Column(
        children: [
          ListTile(
            title: Text('My Videos'),
          ),
          ListTile(
            leading: Icon(Icons.share_sharp),
            title: Text('Share App'),
          ),
          ListTile(
            leading: Icon(Icons.star),
            title: Text('Share App'),
          ),
          ListTile(
            leading: Icon(Icons.policy_outlined),
            title: Text('Share App'),
          ),
        ],
      ),
    ),
  );
}
