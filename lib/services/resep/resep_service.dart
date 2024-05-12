import 'package:cloud_firestore/cloud_firestore.dart';

class ResepService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> sendPengajuanResep(param) async {
    // Add a new document with a generated ID
    _firestore.collection("pengajuan_resep").add(param).then(
        (DocumentReference doc) =>
            print('DocumentSnapshot added with ID: ${doc.id}'));
  }

  Future<void> updatePengajuanResep(param, id) async {
    await _firestore.collection('pengajuan_resep').doc(id).update(param);
  }

  Stream<QuerySnapshot> getPengajuanResepStream() {
    return _firestore.collection("pengajuan_resep").snapshots();
  }
}
