import 'package:cloud_firestore/cloud_firestore.dart';

class databaseService {
  // final String uid;
  databaseService();
  // CollectionReference usersData =
  //     FirebaseFirestore.instance.collection('Users');
  Future updateUserData(
      String name, int age, String phone, String email) async {
    CollectionReference usersData =
        FirebaseFirestore.instance.collection('Users');

    await usersData
        .add({'name': name, 'age': age, 'phone': phone, 'email': email}).then(
            (value) => print('User Added'));
  }
}
