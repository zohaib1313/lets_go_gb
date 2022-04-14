import 'package:flutter/material.dart';

class Menu extends StatelessWidget {
  @override
  Widget build(context) => ListView(children: [
        FlatButton(
            onPressed: () {},
            child: const ListTile(
              leading: Icon(Icons.looks_one),
              title: Text("First Link"),
            )),
        FlatButton(
            onPressed: () {},
            child: const ListTile(
              leading: Icon(Icons.looks_two),
              title: Text("Second Link"),
            ))
      ]);
}
