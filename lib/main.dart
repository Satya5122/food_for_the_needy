import 'package:flutter/material.dart';
import 'package:food_for_the_needy/Models/anonymous_user.dart';
import 'package:food_for_the_needy/Screens/wrapper.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:food_for_the_needy/Services/auth.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    try {
      return StreamProvider<AnonymousUserModel?>.value(
        value: AuthService().user,
        initialData: null,
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          home: Wrapper(),
        ),
      );
    } catch (e) {
      return MaterialApp(debugShowCheckedModeBanner: false, home: Wrapper());
    }
  }
}
