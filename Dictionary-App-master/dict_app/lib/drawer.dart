import 'package:flutter/material.dart';

class Drawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 60),
      width: 300,
      color: Colors.grey,
      child: ListView(
        children: <Widget>[
          Center(
            child: Text(
              "Dictionary",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          ListTile(
            title: Text(
              "English-Vietnamese",
            ),
            leading: Icon(Icons.home),
            onTap: () {},
          ),
          ListTile(
            title: Text(
              "English-English",
            ),
            leading: Icon(Icons.library_books),
            onTap: () {},
          ),
          ListTile(
            title: Text(
              "Vietnamese-English",
            ),
            leading: Icon(Icons.edit),
            onTap: () {},
          ),
          ListTile(
            title: Text(
              "Favorites",
            ),
            leading: Icon(Icons.favorite_border),
            onTap: () {},
          ),
          ListTile(
            title: Text(
              "Your words",
            ),
            leading: Icon(Icons.book),
            onTap: () {},
          ),
          Divider(),
          Text("Communicate"),
          ListTile(
            title: Text(
              "Share",
            ),
            leading: Icon(Icons.share),
            onTap: () {},
          ),
          ListTile(
            title: Text(
              "Help",
            ),
            leading: Icon(Icons.help),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
