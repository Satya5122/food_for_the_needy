// ignore_for_file: unused_local_variable

import 'dart:async';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_for_the_needy/Services/auth.dart';
import 'package:food_for_the_needy/Services/database.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Home extends StatefulWidget {
  Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final AuthService _auth = AuthService();
  late List locations = [];
  double h = 120;
  User user = FirebaseAuth.instance.currentUser!;

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

  List getLocation() {
    List coods = [];
    getCurrentLocation().then((value) => {coods = value});
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

                      setState(() {
                        if (h != 0)
                          h = 0;
                        else
                          h = 120;
                        locations = [
                          new LocationData("Location 1", coods[0], coods[1],
                              17.35846, 38.354455),
                          new LocationData("Location 2", coods[0], coods[1],
                              17.35846, 38.354455),
                          new LocationData("Location 3", coods[0], coods[1],
                              17.35846, 38.354455),
                          new LocationData("Location 4", coods[0], coods[1],
                              17.35846, 38.354455),
                          new LocationData("Location 5", coods[0], coods[1],
                              17.35846, 38.354455),
                          new LocationData("Location 6", coods[0], coods[1],
                              17.35846, 38.354455),
                          new LocationData("Location 7", coods[0], coods[1],
                              17.35846, 38.354455),
                          new LocationData("Location 8", coods[0], coods[1],
                              17.35846, 38.354455),
                          new LocationData("Location 9", coods[0], coods[1],
                              17.35846, 38.354455),
                          new LocationData("Location 10", coods[0], coods[1],
                              17.35846, 38.354455),
                          new LocationData("Location 11", coods[0], coods[1],
                              17.35846, 38.354455),
                          new LocationData("Location 12", coods[0], coods[1],
                              17.35846, 38.354455),
                          new LocationData("Location 13", coods[0], coods[1],
                              17.35846, 38.354455),
                          new LocationData("Location 14", coods[0], coods[1],
                              17.35846, 38.354455),
                          new LocationData("Location 15", coods[0], coods[1],
                              17.35846, 38.354455),
                          new LocationData("Location 16", coods[0], coods[1],
                              17.35846, 38.354455),
                          new LocationData("Location 17", coods[0], coods[1],
                              17.35846, 38.354455),
                          new LocationData("Location 18", coods[0], coods[1],
                              17.35846, 38.354455),
                          new LocationData("Location 19", coods[0], coods[1],
                              17.35846, 38.354455),
                          new LocationData("Location 20", coods[0], coods[1],
                              17.35846, 38.354455),
                        ];
                        locations.sort((a, b) => a.dist.compareTo(b.dist));
                      });
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
                Container(
                  height: 500,
                  child: SingleChildScrollView(
                    child: Column(
                      children: <Widget>[
                        ...locations.map((e) => FlatButton(
                              onPressed: () {
                                FirebaseFirestore.instance
                                    .collection('LocationDB')
                                    .doc(user.uid)
                                    .set({
                                  'curr_lat': e.curr_lat.toString(),
                                  'curr_long': e.curr_lon.toString(),
                                  'chosen_lat': e.lat,
                                  'chosen_lon': e.lon,
                                  'locationName': e.name,
                                  'uid': user.uid
                                });
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) =>
                                        RequestSuccessScreen()));
                              },
                              child: Container(
                                  width: double.infinity,
                                  height: h,
                                  child: Card(
                                    child: Center(
                                      child: Row(
                                        children: <Widget>[
                                          SizedBox(width: 20),
                                          Text((sqrt((e.curr_lat - e.lat) *
                                                      (e.curr_lat - e.lat) +
                                                  (e.curr_lon - e.lon) *
                                                      (e.curr_lon - e.lon)))
                                              .toStringAsFixed(0)),
                                          Text("KM"),
                                          SizedBox(
                                            width: 25,
                                          ),
                                          Text(
                                            e.name,
                                            style: TextStyle(
                                                fontSize: 30,
                                                fontFamily: 'OpenSans'),
                                          ),
                                        ],
                                      ),
                                    ),
                                  )),
                            ))
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

class Userdetails extends StatefulWidget {
  @override
  State<Userdetails> createState() => _UserdetailsState();
}

class _UserdetailsState extends State<Userdetails> {
  late List Userdata = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: Text("User Info"),
      ),
      body: Container(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          SizedBox(height: 25),
          Center(
            child: Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                    color: Colors.blueAccent,
                    borderRadius: BorderRadius.circular(60)),
                child: Icon(
                  Icons.person_rounded,
                  size: 100,
                )),
          ),
          FlatButton(
              onPressed: () async {
                //Userdata = _fetch();
              },
              child: Text("Fetch Details")),
          SizedBox(
            height: 30,
          ),
          Column(
            children: <Widget>[
              ...(Userdata as List).map((e) => Container(
                  width: double.infinity,
                  child: Card(
                    child: Center(
                      child: Text(
                        e,
                        style: TextStyle(fontSize: 30, fontFamily: 'OpenSans'),
                      ),
                    ),
                  )))
            ],
          )
        ],
      )),
    );
  }
}

const _chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
Random _rnd = Random();

class RequestSuccessScreen extends StatefulWidget {
  const RequestSuccessScreen({Key? key}) : super(key: key);

  @override
  _RequestSuccessScreenState createState() => _RequestSuccessScreenState();
}

class _RequestSuccessScreenState extends State<RequestSuccessScreen> {
  static String getRandomString(int length) =>
      String.fromCharCodes(Iterable.generate(
          length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));
  String code = getRandomString(6);
  User user = FirebaseAuth.instance.currentUser!;
  @override
  Widget build(BuildContext context) {
    FirebaseFirestore.instance
        .collection('userCodeDB')
        .doc(user.uid)
        .set({'uid': user.uid, 'foodToken': code});
    return Scaffold(
      body: Container(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: 50,
            ),
            Text("Your food request is succesfully registered"),
            SizedBox(
              height: 20,
            ),
            Text(code)
          ],
        ),
      ),
    );
  }
}

// class MapScreen extends StatefulWidget {
//   double latitude;
//   double longitude;
//   MapScreen(this.latitude, this.longitude);

//   @override
//   _MapScreenState createState() =>
//       _MapScreenState(this.latitude, this.longitude);
// }

// class _MapScreenState extends State<MapScreen> {
//   double lat;
//   double lon;
//   Completer<GoogleMapController> _controller = Completer();
//   _MapScreenState(this.lat, this.lon);
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: GoogleMap(
//         zoomGesturesEnabled: true,
//         mapType: MapType.hybrid,
//         onMapCreated: (GoogleMapController controller) {
//           _controller.complete(controller);
//         },
//         myLocationEnabled: false,
//         zoomControlsEnabled: true,
//         initialCameraPosition: CameraPosition(target: LatLng(lat, lon)),
//       ),
//     );
//   }
// }
class LocationData {
  double curr_lat;
  double curr_lon;
  double lat;
  double lon;
  String name;
  late double dist;
  LocationData(this.name, this.curr_lat, this.curr_lon, this.lat, this.lon) {
    dist = sqrt((curr_lat - lat) * (curr_lat - lat) -
        (curr_lon - lon) * (curr_lon - lon));
  }
}

Future<List> _fetch() async {
  final firebaseUser = FirebaseAuth.instance.currentUser!;
  List dataUser = [];
  if (firebaseUser != null) {
    FirebaseFirestore.instance
        .collection('Users')
        .doc(firebaseUser.uid)
        .get()
        .then((ds) {
      dynamic myEmail = ds.data()!['email'];
      dynamic name = ds.data()!['name'];
      dynamic age = ds.data()!['age'];
      dynamic phone = ds.data()!['phone'];
      dataUser = [myEmail, name, age, phone];
    });
  }
  return dataUser;
}
