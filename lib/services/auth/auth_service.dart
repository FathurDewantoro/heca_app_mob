import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:heca_app_mob/services/shared/shared_preferences.dart';
import 'package:heca_app_mob/utils/flushbar.dart';

class AuthService {
  //instance auth
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  User? getCurrentUser() {
    return _auth.currentUser;
  }

  //sign in
  Future<UserCredential> signInWithEmailPassword(String email, password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);

      await MySharedPreferences().saveIdUser(userCredential.user!.uid);
      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw Exception(e.code);
    }
  }

//   register
  Future<UserCredential> signUpWithEmailPassword(
      String email, password, String nama, context) async {
    try {
      final userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      //save user info to firestore
      await _firestore.collection("users").doc(userCredential.user!.uid).set({
        'uid': userCredential.user!.uid,
        'email': email,
        'nama': nama,
        'role': "pelanggan",
      });

      await userCredential.user!.updateDisplayName(nama);
      signOut();
      return userCredential;
    } on FirebaseAuthException catch (e) {
      FlushbarCustomError(context, e.message);
      throw Exception(e.code);
    }
  }

//get display name
  Future<String?> getDisplayName(String userId) async {
    try {
      // Ambil data pengguna dari Firestore berdasarkan UID
      User? user = _auth.currentUser;
      if (user != null) {
        return user.displayName;
      } else {
        print('User belum login.');
        return null;
      }
    } catch (e) {
      print('Error: $e');
      return null;
    }
  }

//   sign out
  Future<void> signOut() async {
    return await _auth.signOut();
  }
}
