import 'package:cloud_firestore/cloud_firestore.dart';

class databaseService {
  final String uid;
  databaseService(this.uid);
  // CollectionReference usersData =
  //     FirebaseFirestore.instance.collection('Users');
  Future updateUserData(String name, int age, String phone) async {
    CollectionReference usersData =
        FirebaseFirestore.instance.collection('Users');
    dynamic result = usersData
        .doc(uid)
        .set({'name': name, 'age': age.toString(), 'phone': phone}).then(
            (value) => print('values added'));

    return result;
  }
}
