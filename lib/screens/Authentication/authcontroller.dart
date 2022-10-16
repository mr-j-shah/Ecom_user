import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Authcontrol {
  Future<bool> checkUserExists(String num) async {
    // check if user already exists in firebase auth
    final snapShot =
        await FirebaseFirestore.instance.collection('user').doc(num).get();

    if (snapShot.exists) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> checkReuestExist(String num) async {
    // check if user already exists in firebase auth
    final snapShot = await FirebaseFirestore.instance
        .collection('requestUser')
        .doc(num)
        .get();

    if (snapShot.exists) {
      return true;
    } else {
      return false;
    }
  }

  String? email;

  Future<UserCredential> signInWithGoogle(
      GoogleSignInAccount googleUser) async {
    // Trigger the authentication flow
    // final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  void signOut() async {
    await FirebaseAuth.instance.signOut();
    GoogleSignIn().signOut();
  }
}
