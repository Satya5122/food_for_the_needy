import 'package:flutter/material.dart';
import 'package:food_for_the_needy/Screens/authenticate/authenticate.dart';
import 'package:food_for_the_needy/Services/auth.dart';

class SignIn extends StatefulWidget {
  final Function changeState;
  SignIn({required this.changeState});

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  String error = "";
  //text field state
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.tealAccent,
      appBar: AppBar(
        actions: <Widget>[
          ElevatedButton.icon(
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.amber)),
              onPressed: () {
                widget.changeState();
              },
              icon: Icon(Icons.person),
              label: Text('Register'))
        ],
        elevation: 0.0,
        backgroundColor: Colors.teal,
        title: Text("Food For The Needy"),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
          // child: ElevatedButton(
          //   onPressed: () async {
          //     dynamic result = await _auth.signInAnon();
          //     if (result != null) {
          //       print("logged in");
          //       print(result.uid);
          //     } else {
          //       print("not logged in");
          //     }
          //   },
          //   child: Text("SignIn"),
          // ),
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 20.0,
                ),
                Text(
                  "Sign In",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      color: Colors.green,
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'OpenSans'),
                ),
                SizedBox(
                  height: 30,
                ),

                TextFormField(
                  validator: (val) => val!.isEmpty ? 'Enter an email' : null,
                  decoration: InputDecoration(label: Text("Email")),
                  autofocus: true,
                  controller: emailController,
                  cursorColor: Colors.amberAccent,
                  cursorHeight: 30,
                  onChanged: (val) {},
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  validator: (val) => val!.length < 6
                      ? 'Enter a password of min 6 characters'
                      : null,
                  decoration: InputDecoration(label: Text("Password")),
                  autofocus: true,
                  controller: passwordController,
                  cursorColor: Colors.amberAccent,
                  cursorHeight: 30,
                  obscureText: true,
                  onChanged: (val) {},
                ),
                SizedBox(
                  height: 20,
                ),
                //this button should fire a async function to make changes aor access the firebase
                ElevatedButton(
                    style: ButtonStyle(
                        elevation: MaterialStateProperty.all(10.0),
                        backgroundColor:
                            MaterialStateProperty.all(Colors.amberAccent)),
                    onPressed: () async {
                      //Interact with firebase and login the user
                      if (_formKey.currentState!.validate()) {
                        dynamic result = await _auth.signinWithEmailAndPassword(
                            emailController.text, passwordController.text);
                        if (result == null) {
                          setState(() {
                            error = "Please Try Again";
                          });
                        }
                      }
                    },
                    child:
                        Text("Sign In", style: TextStyle(color: Colors.black))),
                Text(error),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
