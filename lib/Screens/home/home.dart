// ignore_for_file: unused_local_variable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_for_the_needy/Services/auth.dart';
import 'package:geolocator/geolocator.dart';

class Home extends StatefulWidget {
  Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var locationMessage = "";

  final AuthService _auth = AuthService();
  User user = FirebaseAuth.instance.currentUser!;
  List coods = [[], [], [], [], [], []];
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

  Future getCurrentLocation() async {
    List coods;
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    coods = [position.latitude, position.longitude];
    return coods;
  }

  String latitude = '';
  String longitude = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.cyan,
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => Userdetails()));
              },
              icon: Icon(Icons.settings)),
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
                ElevatedButton(
                    onPressed: () async {
                      List coods = await getCurrentLocation();
                      setState(() {
                        latitude = coods[0].toString();
                        longitude = coods[1].toString();
                      });

                      FirebaseFirestore.instance
                          .collection('LocationDB')
                          .doc(user.uid)
                          .set({'latitiude': latitude, 'longitude': longitude});
                    },
                    child: Container(
                      width: 200,
                      child: Row(
                        children: <Widget>[
                          Icon(Icons.location_city_sharp),
                          SizedBox(
                            width: 30,
                          ),
                          Text(
                            "Choose Your Location",
                            style: TextStyle(fontSize: 10),
                          )
                        ],
                      ),
                    )),
                SizedBox(
                  height: 20,
                ),
                Text("$latitude,$longitude")
              ],
            ),
          ),
        ));
  }
}

class Userdetails extends StatelessWidget {
  const Userdetails({Key? key}) : super(key: key);
  void getCurrentLocation() {
    Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((value) {
      var last_position = Geolocator.getLastKnownPosition();
      print(last_position);
      print("$value.longitude ,$value.latitude");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("User Info"),
      ),
      body: Container(
        child: ElevatedButton(
          onPressed: () {
            getCurrentLocation();
            Navigator.of(context).pop();
          },
          child: Text("Home"),
        ),
      ),
    );
  }
}
