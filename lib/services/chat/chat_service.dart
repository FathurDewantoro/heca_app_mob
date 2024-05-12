import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:heca_app_mob/models/messages_model.dart';
import 'package:heca_app_mob/services/user/user_service.dart';

class ChatService {
  //get instance firestore
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  UserService userService = UserService();

  //get user stream
  Stream<List<Map<String, dynamic>>> getUsersStream() {
    return _firestore.collection("users").snapshots().map((event) {
      return event.docs.map((e) {
        final user = e.data();

        return user;
      }).toList();
    });
  }

  //send message
  Future<void> sendMessage(String receiverId, String senderId, message,
      nama_dokter, nama_pengirim, String role) async {
    final String currentUserId = _auth.currentUser!.uid;
    final String currentEmail = _auth.currentUser!.email!;
    final Timestamp timestamp = Timestamp.now();

    //create a new message
    MessageModel newMessage = MessageModel(
      senderId: currentUserId,
      senderEmail: currentEmail,
      receiverId: receiverId,
      message: message,
      timestamp: timestamp,
    );

    print(
        "current = $currentUserId, sender = $senderId, receiver = $receiverId");

    List<String> ids;

    if (role == "dokter") {
      ids = [
        senderId,
        receiverId,
      ];
    } else {
      ids = [
        receiverId,
        currentUserId,
      ];
    }

    String chatRoomId = ids.join("_");

    //add new message to database
    await _firestore
        .collection("chats_rooms")
        .doc(chatRoomId)
        .collection("messages")
        .add(newMessage.toMap());

    var documentReference =
        await _firestore.collection("chats_rooms").doc(chatRoomId).get();

    if (role == "dokter") {
      await _firestore.collection("chats_rooms").doc(chatRoomId).update({
        "senderId": documentReference['senderId'],
        "receiverId": documentReference['receiverId'],
        "nama_dokter": documentReference['nama_dokter'],
        "nama_pengirim": documentReference['nama_pengirim'],
        "pesan_terakhir": message,
        "timestamp": timestamp,
      });
    } else {
      await _firestore.collection("chats_rooms").doc(chatRoomId).set({
        "senderId": currentUserId,
        "receiverId": receiverId,
        "nama_dokter": nama_dokter,
        "nama_pengirim": nama_pengirim,
        "pesan_terakhir": message,
        "timestamp": timestamp,
      });
    }
  }

  //get messages
  Stream<QuerySnapshot> getMessages(String userId, otherUserId) {
    List<String> ids = [
      userId,
      otherUserId,
    ];
    String chatRoomId = ids.join("_");

    return _firestore
        .collection("chats_rooms")
        .doc(chatRoomId)
        .collection("messages")
        .orderBy("timestamp", descending: false)
        .snapshots();
  }

  Stream<QuerySnapshot> getAllMessage() {
    testGetData();
    return _firestore.collection("chats_rooms").snapshots();
  }

  testGetData() async {
    await _firestore
      ..collection("chats_rooms").get().then((event) {
        for (var doc in event.docs) {
          print("${doc.id} => ${doc.data()}");
        }
      });

    // Stream<QuerySnapshot<Map<String, dynamic>>> data = await _firestore
    //     .collection("chats_rooms")
    //     .doc("2vpCmh2u2bRgVbadFt3LXKLIgyy2_ZILXuG9JjuN8XxuQsr7HqY61nOA2")
    //     .collection("messages")
    //     .orderBy("timestamp", descending: false)
    //     .snapshots();
    //
    // print("100 | $runtimeType | Oleh datane : ${data.first.toString()}");
  }
}
