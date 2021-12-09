import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:syncfusion_flutter_xlsio/xlsio.dart' as xlsio;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.purple,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text("NGO DASHBOARD"),
        centerTitle: true,
      ),
      body: Container(
        width: double.infinity,
        alignment: Alignment.center,
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 25,
            ),
            FlatButton(
              onPressed: createExcelFoodRequests,
              child: Text("Get Food Rquests Data"),
              autofocus: true,
            ),
            SizedBox(
              height: 25,
            ),
            FlatButton(
                onPressed: createExcelFoodTokens,
                child: Text("Get Food Tokens Data"))
          ],
        ),
      ),
    );
  }

  Future<void> createExcelFoodTokens() async {
    final xlsio.Workbook workbook = xlsio.Workbook();
    final xlsio.Worksheet sheet = workbook.worksheets[0];

    sheet.getRangeByName("A1").setText("Name");
    sheet.getRangeByName("B1").setText("User Email");
    sheet.getRangeByName("C1").setText("Token number");

    //Add data to xlsx file
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection("userCodeDB").get();
    for (int i = 0; i < querySnapshot.docs.length; i++) {
      var a = querySnapshot.docs[i];

      DocumentSnapshot userQuery = await FirebaseFirestore.instance
          .collection("Users")
          .doc(a["uid"])
          .get();

      sheet
          .getRangeByName("A" + (sheet.getLastRow() + 1).toString())
          .setText(userQuery["name"]);
      sheet
          .getRangeByName("B" + (sheet.getLastRow()).toString())
          .setText(userQuery["email"]);
      sheet
          .getRangeByName("C" + (sheet.getLastRow()).toString())
          .setText(a["foodToken"]);
    }

    final List<int> bytes = workbook.saveAsStream();
    workbook.dispose();

    final String path = (await getApplicationSupportDirectory()).path;
    final String fileName = '$path/FoodTokens.xlsx';
    final File file = File(fileName);
    await file.writeAsBytes(bytes, flush: true);
    OpenFile.open(fileName);
  }

  Future<void> createExcelFoodRequests() async {
    final xlsio.Workbook workbook = xlsio.Workbook();
    final xlsio.Worksheet sheet = workbook.worksheets[0];

    sheet.getRangeByName("A1").setText("Name");
    sheet.getRangeByName("D1").setText("User Email");
    sheet.getRangeByName("B1").setText("lat");
    sheet.getRangeByName("C1").setText("lon");
    //Add data to xlsx file
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection("LocationDB").get();
    for (int i = 0; i < querySnapshot.docs.length; i++) {
      var a = querySnapshot.docs[i];

      DocumentSnapshot userQuery = await FirebaseFirestore.instance
          .collection("Users")
          .doc(a["uid"])
          .get();

      sheet
          .getRangeByName("A" + (sheet.getLastRow() + 1).toString())
          .setText(userQuery["name"]);
      sheet
          .getRangeByName("B" + (sheet.getLastRow()).toString())
          .setText(a["chosen_lat"].toString());
      sheet
          .getRangeByName("C" + (sheet.getLastRow()).toString())
          .setText(a["chosen_lon"].toString());
      sheet
          .getRangeByName("D" + (sheet.getLastRow()).toString())
          .setText(userQuery["email"]);
    }

    final List<int> bytes = workbook.saveAsStream();
    workbook.dispose();

    final String path = (await getApplicationSupportDirectory()).path;
    final String fileName = '$path/FoodRequests.xlsx';
    final File file = File(fileName);
    await file.writeAsBytes(bytes, flush: true);
    OpenFile.open(fileName);
  }
}
