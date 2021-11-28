// ignore_for_file: unused_local_variable

import 'dart:async';
import 'dart:ffi';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_for_the_needy/Services/auth.dart';
import 'package:food_for_the_needy/Services/database.dart';
import 'package:geolocator/geolocator.dart';

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
  List stalls = [];
  @override
  void initState() {
    // getuserdata();
    // TODO: implement initState
    super.initState();
    fetchStalls();
  }

  fetchStalls() async {
    dynamic result = await databaseService(user.uid).getStallsData();
    if (result != null) {
      setState(() {
        stalls = result;
      });
    }
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

                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => LocationsPage(coods)));
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
                ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => AddPage()));
                    },
                    child: Text("Add"))
              ],
            ),
          ),
        ));
  }
}

class AddPage extends StatefulWidget {
  const AddPage({Key? key}) : super(key: key);

  @override
  _AddPageState createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  static String getRandomString(int length) =>
      String.fromCharCodes(Iterable.generate(
          length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));
  User user = FirebaseAuth.instance.currentUser!;
  TextEditingController nameController = TextEditingController();
  TextEditingController latController = TextEditingController();
  TextEditingController lonController = TextEditingController();
  TextEditingController idController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          SizedBox(
            height: 50,
          ),
          Text("id"),
          TextField(
            controller: idController,
          ),
          Text('name'),
          TextField(
            controller: nameController,
          ),
          Text('latitude'),
          TextField(
            controller: latController,
          ),
          Text('longitude'),
          TextField(
            controller: lonController,
          ),
          ElevatedButton(
              onPressed: () {
                FirebaseFirestore.instance
                    .collection('stallsDB')
                    .doc(idController.text)
                    .set({
                  'LocationName': nameController.text,
                  'lat': double.parse(latController.text),
                  'lon': double.parse(lonController.text)
                });
              },
              child: Text("ADD"))
        ],
      ),
    );
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

class FindDistance {
  double distance(lat1, lon1, lat2, lon2) {
    var p = 0.017453292519943295; // Math.PI / 180

    var a = 0.5 -
        cos((lat2 - lat1) * p) / 2 +
        cos(lat1 * p) * cos(lat2 * p) * (1 - cos((lon2 - lon1) * p)) / 2;

    return 12742 * asin(sqrt(a)); // 2 * R; R = 6371 km
  }
}

class LocationsPage extends StatefulWidget {
  List coods;
  LocationsPage(this.coods);
  @override
  State<LocationsPage> createState() => _LocationsPageState(coods);
}

class _LocationsPageState extends State<LocationsPage> {
  User user = FirebaseAuth.instance.currentUser!;
  List coods;
  _LocationsPageState(this.coods);
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amberAccent,
      body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection('stallsDB').snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final List<DocumentSnapshot> documents = snapshot.data!.docs;
              return ListView(
                  children: documents
                      .map((doc) => FlatButton(
                            onPressed: () {
                              FirebaseFirestore.instance
                                  .collection('LocationDB')
                                  .doc(user.uid)
                                  .set({
                                'curr_lat': coods[0].toString(),
                                'curr_long': coods[1].toString(),
                                'chosen_lat': doc['lat'],
                                'chosen_lon': doc['lon'],
                                'locationName': doc['LocationName'],
                                'uid': user.uid
                              });
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) =>
                                      RequestSuccessScreen()));
                            },
                            child: Container(
                                width: double.infinity,
                                height: 120,
                                child: Card(
                                  child: Center(
                                    child: Row(
                                      children: <Widget>[
                                        SizedBox(width: 20),
                                        Text((FindDistance()
                                            .distance(coods[0], coods[1],
                                                doc['lat'], doc['lon'])
                                            .toStringAsFixed(0))),
                                        Text("KM"),
                                        SizedBox(
                                          width: 25,
                                        ),
                                        Text(
                                          doc['LocationName'],
                                          style: TextStyle(
                                              fontSize: 30,
                                              fontFamily: 'OpenSans'),
                                        ),
                                      ],
                                    ),
                                  ),
                                )),
                          ))
                      .toList());
            } else if (snapshot.hasError) {
              return Text('Its Error!');
            } else {
              return Text("Unkown Error");
            }
          }),
    );
  }
}
