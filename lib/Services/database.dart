import 'package:cloud_firestore/cloud_firestore.dart';

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
}
