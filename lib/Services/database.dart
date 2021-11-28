import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class databaseService {
  final String? uid;
  databaseService(this.uid);
  // CollectionReference usersData =
  //     FirebaseFirestore.instance.collection('Users');
  Future updateUserData(
      String name, int age, String phone, String email) async {
    FirebaseFirestore.instance
        .collection('Users')
        .doc(uid)
        .set({'name': name, 'age': age, 'phone': phone, 'email': email});
  }

  Future fetch() async {
    final firebaseUser = FirebaseAuth.instance.currentUser!;
    List dataUser = [];
    if (firebaseUser != null) {
      FirebaseFirestore.instance.collection('Users').doc(uid).get().then((ds) {
        dynamic myEmail = ds.data()!['email'];
        dynamic name = ds.data()!['name'];
        dynamic age = ds.data()!['age'];
        dynamic phone = ds.data()!['phone'];
        dataUser = [myEmail, name, age, phone];
      }).catchError((e) {
        print(e);
      });
    }

    return dataUser;
  }
}
