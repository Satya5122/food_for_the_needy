import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:food_for_the_needy/Models/anonymous_user.dart';
import 'package:food_for_the_needy/Services/database.dart';

class AuthService {
  //create a user object on firebase user
  AnonymousUserModel? _userFromFirebaseUser(User user) {
    return AnonymousUserModel(user.uid);
  }

  final FirebaseAuth _auth = FirebaseAuth.instance;

  //Auth change user stream
  Stream<AnonymousUserModel?> get user {
    return _auth
        .authStateChanges()
        .map((event) => event != null ? _userFromFirebaseUser(event) : null);
    //.map(_userFromFirebaseUser);
  }

  //sign in anonymously
  Future signInAnon() async {
    try {
      UserCredential result = await _auth.signInAnonymously(); //AuthResult
      User? user = result.user; //FirebaseUser

      return _userFromFirebaseUser(user!);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //sign in with email and password
  Future signinWithEmailAndPassword(String email, String password) async {
    try {
      //fire a request to firebase
      dynamic result =
          _auth.signInWithEmailAndPassword(email: email, password: password);
      User user = result.user;
      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //register with email and passsword
  Future registerWithEmailAndPassword(String name, String age, String phone,
      String email, String password) async {
    int a = int.parse(age);

    try {
      //fire a request to firebase

      _auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) {
        databaseService(value.user!.uid).updateUserData(name, a, phone, email);
      });

      final FirebaseAuth auth = FirebaseAuth.instance;
      User user = auth.currentUser!;

      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //sign out
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
