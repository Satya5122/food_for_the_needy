import 'package:flutter/material.dart';
import 'package:food_for_the_needy/Screens/authenticate/register.dart';
import 'package:food_for_the_needy/Screens/authenticate/sign_in.dart';

class Authenticate extends StatefulWidget {
  const Authenticate({Key? key}) : super(key: key);

  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  bool showSignIn = true;
  void toggleView() {
    setState(() {
      showSignIn = !showSignIn;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showSignIn) {
      return SignIn(
        changeState: toggleView,
      );
    } else {
      return Register(
        changeState: toggleView,
      );
    }
  }
}
