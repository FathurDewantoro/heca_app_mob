import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:heca_app_mob/services/auth/auth_service.dart';

class UserService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final AuthService authService = AuthService();

  Future<String?> getUsername() async {
    var uid = authService.getCurrentUser()!.uid;
    var data = await _firestore.collection("users").doc(uid).get();
    return data['nama'];
  }

  Future<DocumentSnapshot<Map<String, dynamic>>> getUserData(String uid) async {
    var data = await _firestore.collection("users").doc(uid).get();
    return data;
  }
}
