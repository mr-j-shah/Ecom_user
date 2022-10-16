import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Requestuser {
  getCurrentUserDetails(String s) async {
    await Future.wait([setNameDetails(s)]).then((value) {
      print(value);
    });
    return Requestuser();
  }

  String? Name, phonenumber, address;
  static final Requestuser _currentUser = Requestuser._internal();
  factory Requestuser() {
    return _currentUser;
  }

  Requestuser._internal();
  Future<void> setNameDetails(String s) async {
    final snapShot = FirebaseFirestore.instance
        .collection('requestUser')
        .doc(s)
        .get()
        .then((snapshot) {
      final data = snapshot.data();
      if (data != null) {
        Requestuser().Name = data['Name'] ?? "User";
        Requestuser().phonenumber = data['phone'] ?? "";
        Requestuser().address = data['address'] ?? "";
      }
    });
  }
}

class User {
  getCurrentUserDetails(String s) async {
    await Future.wait([setNameDetails(s)]).then((value) {
      print(value);
    });
    return Requestuser();
  }

  String? Name, phonenumber, address, email;
  static final User _currentUser = User._internal();
  factory User() {
    return _currentUser;
  }

  User._internal();
  Future<void> setNameDetails(String s) async {
    final snapShot = FirebaseFirestore.instance
        .collection('user')
        .doc(s)
        .get()
        .then((snapshot) {
      final data = snapshot.data();
      if (data != null) {
        Name = data['Name'] ?? "";
        phonenumber = data['phone'] ?? "";
        address = data['address'] ?? "";
        email = data['email'] ?? "";
      }
    });
  }
}
