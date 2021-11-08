// ignore_for_file: unused_local_variable

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_for_the_needy/Services/auth.dart';

class Home extends StatefulWidget {
  Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final AuthService _auth = AuthService();
  User user = FirebaseAuth.instance.currentUser!;
  List locations = [
    'location1',
    'location2',
    'location3',
    'location4',
    'location5',
    'location6'
  ];
  // Future<void> getuserdata() async {
  //   User userdata =
  //   setState(() {
  //     user = userdata;
  //   });
  // }

  @override
  void initState() {
    // getuserdata();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.cyan,
        appBar: AppBar(
          leading: IconButton(onPressed: () {}, icon: Icon(Icons.settings)),
          backgroundColor: Colors.cyan,
          elevation: 0.0,
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
          width: double.infinity,
          color: Colors.cyan,
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                SizedBox(height: 30),
                Text(
                  "Hello ${user.email}",
                  style: TextStyle(fontSize: 30),
                ),
                SizedBox(height: 30),
                ElevatedButton(onPressed: () {}, child: Text("Find stall")),
                SizedBox(
                  height: 20,
                ),
                Card(
                  child: SingleChildScrollView(
                    child: Column(
                      children: <Widget>[
                        ...locations.map((e) => Container(
                            width: double.infinity,
                            height: 120,
                            child: Card(
                              child: Center(
                                child: Text(
                                  e,
                                  style: TextStyle(
                                      fontSize: 30, fontFamily: 'OpenSans'),
                                ),
                              ),
                            )))
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
