import 'package:flutter/material.dart';
import 'package:food_for_the_needy/Services/auth.dart';

class Home extends StatelessWidget {
  final AuthService _auth = AuthService();
  Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green,
      appBar: AppBar(
        backgroundColor: Colors.cyan,
        elevation: 0.0,
        title: Text("Food For The Needy"),
        actions: <Widget>[
          ElevatedButton.icon(
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.amber)),
              onPressed: () async {
                await _auth.signOut();
              },
              icon: Icon(Icons.person),
              label: Text("Logout"))
        ],
      ),
      body: Container(
        color: Colors.white,
      ),
    );
  }
}
