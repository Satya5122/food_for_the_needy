import 'package:flutter/material.dart';
import 'package:food_for_the_needy/Models/anonymous_user.dart';
import 'package:food_for_the_needy/Screens/authenticate/authenticate.dart';
import 'package:food_for_the_needy/Screens/home/home.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<AnonymousUserModel?>(context);
    print(user);
    //return either home or authenticate widget
    if (user == null) {
      return Authenticate();
    } else {
      return Home();
    }
  }
}
