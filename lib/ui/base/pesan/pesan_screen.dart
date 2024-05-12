import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:heca_app_mob/services/auth/auth_service.dart';
import 'package:heca_app_mob/services/chat/chat_service.dart';
import 'package:heca_app_mob/services/user/user_service.dart';
import 'package:heca_app_mob/ui/chat/chat_page.dart';
import 'package:heca_app_mob/utils/colors.dart';
import 'package:heca_app_mob/utils/screen_size.dart';
import 'package:heca_app_mob/utils/text_style.dart';
import 'package:iconly/iconly.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class PesanScreen extends StatefulWidget {
  const PesanScreen({super.key});

  @override
  State<PesanScreen> createState() => _PesanScreenState();
}

class _PesanScreenState extends State<PesanScreen> {
  final ChatService _chatService = ChatService();
  final UserService userService = UserService();
  final AuthService authService = AuthService();

  User? currentUser;
  String? role;

  getUserData() async {
    currentUser = await authService.getCurrentUser();
    var data = await userService.getUserData(currentUser!.uid);
    role = data['role'];
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    getUserData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteBackrground,
      appBar: AppBar(
        backgroundColor: whiteColor,
        title: Text(
          "Pesan Chat",
          style: titleAppBar(primaryColor),
        ),
        centerTitle: true,
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(1.0), // Tinggi border bottom
          child: Container(
            color: borderColor, // Warna border bottom
            height: 1, // Tinggi border bottom
          ),
        ),
      ),
      body: StreamBuilder(
        stream: _chatService.getAllMessage(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text("Error"));
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: LoadingAnimationWidget.waveDots(
                color: primaryColor,
                size: 36,
              ),
            );
          }
          print(snapshot.data!.docs.toString());
          return ListView(
            padding: EdgeInsets.only(left: 20, top: 20, right: 20),
            children: snapshot.data!.docs
                .map((doc) => buildMessageItem(doc))
                .toList(),
          );
        },
      ),
      // floatingActionButton: FloatingActionButton(
      //   elevation: 0,
      //   onPressed: () {
      //     // Tindakan yang ingin dilakukan ketika tombol ditekan
      //     print('Floating action button pressed');
      //   },
      //   child: Image.asset(
      //     'assets/images/add_chat_icon.png',
      //     width: 30,
      //   ), // Ikona yang ditampilkan di dalam tombol
      //   backgroundColor: whiteColor, // Warna latar belakang tombol
      //   shape: CircleBorder(
      //       side: BorderSide(
      //           color: borderColor, width: 1.0)), // Menambahkan border radius
      // ),
    );
  }

  Widget buildMessageItem(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    if (role == "dokter") {
      print(currentUser!.uid);
      if (data['receiverId'] == currentUser!.uid) {
        return CardPesan(data['senderId'], data['receiverId'],
            data['nama_pengirim'], data['pesan_terakhir'], "dokter");
      } else {
        return SizedBox();
      }
    } else {
      if (data['senderId'] == currentUser!.uid) {
        return CardPesan(data['receiverId'], data['senderId'],
            data['nama_dokter'], data['pesan_terakhir'], "pelanggan");
      } else {
        return SizedBox();
      }
    }
  }

  Column CardPesan(String receiverId, String senderId, String nama,
      String pesanTerakhir, String role) {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ChatPage(
                    receiverId: receiverId,
                    senderId: senderId,
                    userName: nama,
                    role: role,
                  ),
                ));
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 10),
                    decoration: BoxDecoration(
                        color: whiteColor,
                        borderRadius: BorderRadius.circular(50),
                        border: Border.all(color: borderColor)),
                    width: 50,
                    height: 50,
                    child: Icon(
                      IconlyBold.profile,
                      color: primaryColor,
                      size: 30,
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        nama,
                        style: titleButton(grayColor900),
                      ),
                      Text(
                        pesanTerakhir,
                        style: bodyLarge(grayColor500),
                      )
                    ],
                  )
                ],
              ),
              Text(
                "10.30",
                style: labelLarge(grayColor900),
              )
            ],
          ),
        ),
        Divider(
          height: 40,
          color: borderColor,
        )
      ],
    );
  }
}
