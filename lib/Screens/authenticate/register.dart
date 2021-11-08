import 'package:flutter/material.dart';
import 'package:food_for_the_needy/Services/auth.dart';

class Register extends StatefulWidget {
  final Function changeState;
  Register({required this.changeState});

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<
      FormState>(); //to identify our form and we are going to associate our for with this key
  String error = "";
  //text field state
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController verifypasswordController = TextEditingController();

  TextEditingController userName = TextEditingController();
  TextEditingController userAge = TextEditingController();
  TextEditingController userPhone = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.tealAccent,
      appBar: AppBar(
        actions: <Widget>[
          ElevatedButton.icon(
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.amber)),
            icon: Icon(Icons.person),
            onPressed: () {
              widget.changeState();
            },
            label: Text("SignIn"),
          )
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
                  "Register",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      color: Colors.green,
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'OpenSans'),
                ),
                SizedBox(
                  height: 20.0,
                ),
                TextFormField(
                  validator: (val) => val!.isEmpty ? 'Enter your name' : null,
                  decoration: InputDecoration(label: Text("Name")),
                  autofocus: true,
                  controller: userName,
                  cursorColor: Colors.amberAccent,
                  cursorHeight: 30,
                  onChanged: (val) {},
                ),
                SizedBox(
                  height: 30,
                ),
                TextFormField(
                  validator: (val) =>
                      val!.isEmpty ? 'Enter your phone number' : null,
                  decoration: InputDecoration(label: Text("Phone number")),
                  autofocus: true,
                  controller: userPhone,
                  cursorColor: Colors.amberAccent,
                  cursorHeight: 30,
                  onChanged: (val) {},
                ),
                SizedBox(
                  height: 30,
                ),
                TextFormField(
                  validator: (val) => val!.isEmpty ? 'Enter your age' : null,
                  decoration: InputDecoration(label: Text("Age")),
                  autofocus: true,
                  controller: userAge,
                  cursorColor: Colors.amberAccent,
                  cursorHeight: 30,
                  onChanged: (val) {},
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
                TextFormField(
                    validator: (val) => val!.length < 6
                        ? 'Enter a password of min 6 characters'
                        : null,
                    controller: verifypasswordController,
                    decoration: InputDecoration(label: Text("Retype Password")),
                    autofocus: true,
                    cursorColor: Colors.amberAccent,
                    cursorHeight: 30,
                    obscureText: true,
                    onChanged: (val) {}),
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
                      //Interact with firebase and register the user

                      if (_formKey.currentState!.validate()) {
                        dynamic result =
                            await _auth.registerWithEmailAndPassword(
                                userName.text,
                                userAge.text,
                                userPhone.text,
                                emailController.text,
                                passwordController.text);

                        if (result == null) {
                          setState(() {
                            error = "Please give valid credentials";
                          });
                        }
                      }
                    },
                    child: Text("Register",
                        style: TextStyle(color: Colors.black))),
                Text(error),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
