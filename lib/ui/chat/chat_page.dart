import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:heca_app_mob/services/auth/auth_service.dart';
import 'package:heca_app_mob/services/chat/chat_service.dart';
import 'package:heca_app_mob/services/user/user_service.dart';
import 'package:heca_app_mob/utils/colors.dart';
import 'package:heca_app_mob/utils/formatter.dart';
import 'package:heca_app_mob/utils/screen_size.dart';
import 'package:heca_app_mob/utils/styles.dart';
import 'package:heca_app_mob/utils/text_style.dart';
import 'package:iconly/iconly.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class ChatPage extends StatefulWidget {
  final String receiverId;
  final String senderId;
  final String userName;
  final String role;
  const ChatPage(
      {super.key,
      required this.receiverId,
      required this.senderId,
      required this.userName,
      required this.role});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  var chats = [
    {"sender_id": 1, "pesan": "Selamat pagi dok", "waktu": "10:20"},
    {
      "sender_id": 2,
      "pesan": "Iya Pagi, gimana? ada keluhan apa yang mau ditanyakan?",
      "waktu": "10:22"
    },
    {"sender_id": 1, "pesan": "Saya merasa pusing dok", "waktu": "10:23"},
  ];

  final TextEditingController pesanController = TextEditingController();

  String namaPengirim = "";

  final ChatService _chatService = ChatService();
  final AuthService _authService = AuthService();
  final UserService _userService = UserService();

  void sendMessage() async {
    var currentUser = await _authService.getCurrentUser();
    if (pesanController.text.isNotEmpty) {
      if (widget.role == "dokter") {
        await _chatService.sendMessage(widget.receiverId, widget.senderId,
            pesanController.text, widget.userName, namaPengirim, "dokter");
      } else {
        await _chatService.sendMessage(widget.receiverId, currentUser!.uid,
            pesanController.text, widget.userName, namaPengirim, "pelanggan");
      }

      pesanController.clear();
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setPengirim();
    print(
        "Sender : ${widget.senderId}, receiver : ${widget.receiverId}, role ${widget.role}");
  }

  setPengirim() async {
    namaPengirim = (await UserService().getUsername())!;
  }

  @override
  Widget build(BuildContext context) {
    String senderId = _authService.getCurrentUser()!.uid;
    return Scaffold(
      backgroundColor: whiteBackrground,
      appBar: AppBar(
        toolbarHeight: 85,
        backgroundColor: whiteColor,
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(IconlyLight.arrow_left_2),
        ),
        title: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                color: whiteColor,
                borderRadius: BorderRadius.circular(50),
                border: Border.all(color: borderColor),
              ),
              width: 40,
              height: 40,
              child: Icon(
                IconlyBold.profile,
                color: primaryColor,
                size: 22,
              ),
            ),
            Text(
              widget.userName,
              style: titleSmall(primaryColor),
            )
          ],
        ),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(1.0), // Tinggi border bottom
          child: Container(
            color: borderColor, // Warna border bottom
            height: 1, // Tinggi border bottom
          ),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
              child: StreamBuilder(
            stream: widget.role == "pelanggan"
                ? _chatService.getMessages(
                    widget.receiverId,
                    senderId,
                  )
                : _chatService.getMessages(
                    senderId,
                    widget.receiverId,
                  ),
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
          )),
          // Expanded(
          //   child: ListView.builder(
          //     padding: EdgeInsets.only(left: 20, top: 20, right: 20),
          //     itemCount: chats.length,
          //     itemBuilder: (context, index) {
          //       if (chats[index]['sender_id'] == 1) {
          //         return Column(
          //           crossAxisAlignment: CrossAxisAlignment.end,
          //           children: [
          //             Container(
          //               constraints: BoxConstraints(
          //                   maxWidth: ScreenSize.setWidth(context, 0.6)),
          //               padding:
          //                   EdgeInsets.symmetric(horizontal: 14, vertical: 8),
          //               decoration: BoxDecoration(
          //                   color: primaryColor,
          //                   borderRadius: BorderRadius.only(
          //                     topLeft: Radius.circular(25),
          //                     topRight: Radius.circular(25),
          //                     bottomLeft: Radius.circular(25),
          //                   )),
          //               child: Text(
          //                 chats[index]['pesan'].toString(),
          //                 style: bodyLarge(whiteColor),
          //               ),
          //             ),
          //             Text(
          //               chats[index]['waktu'].toString(),
          //               style: TextStyle(
          //                   fontSize: 12,
          //                   fontWeight: FontWeight.w600,
          //                   color: grayColor500),
          //               textAlign: TextAlign.end,
          //             ),
          //             SizedBox(
          //               height: 16,
          //             )
          //           ],
          //         );
          //       } else {
          //         return Column(
          //           crossAxisAlignment: CrossAxisAlignment.start,
          //           children: [
          //             Container(
          //               constraints: BoxConstraints(
          //                   maxWidth: ScreenSize.setWidth(context, 0.6)),
          //               padding:
          //                   EdgeInsets.symmetric(horizontal: 14, vertical: 8),
          //               decoration: BoxDecoration(
          //                   color: bubbleChatGrayColor,
          //                   borderRadius: BorderRadius.only(
          //                     topLeft: Radius.circular(25),
          //                     topRight: Radius.circular(25),
          //                     bottomRight: Radius.circular(25),
          //                   )),
          //               child: Text(
          //                 chats[index]['pesan'].toString(),
          //                 style: bodyLarge(whiteColor),
          //               ),
          //             ),
          //             Text(
          //               chats[index]['waktu'].toString(),
          //               style: TextStyle(
          //                   fontSize: 12,
          //                   fontWeight: FontWeight.w600,
          //                   color: grayColor500),
          //               textAlign: TextAlign.end,
          //             ),
          //             SizedBox(
          //               height: 16,
          //             )
          //           ],
          //         );
          //       }
          //     },
          //   ),
          // ),
          Container(
              width: ScreenSize.getWidth(context),
              height: 80,
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 14),
              decoration: BoxDecoration(
                color: whiteColor,
                border: Border(
                  top: BorderSide(width: 1, color: borderColor),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: ScreenSize.setWidth(context, 0.75),
                    child: TextField(
                      controller: pesanController,
                      decoration: InputDecorationCustom("Tulis Pesan..."),
                      obscureText: false,
                    ),
                  ),
                  GestureDetector(
                    onTap: sendMessage,
                    child: Container(
                      child: Icon(
                        IconlyBold.send,
                        color: whiteColor,
                      ),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(14),
                          color: primaryColor),
                      height: ScreenSize.setWidth(context, 0.12),
                      width: ScreenSize.setWidth(context, 0.12),
                    ),
                  )
                ],
              ))
        ],
      ),
    );
  }

  Widget buildMessageItem(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    if (data['receiverId'] != widget.receiverId) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            constraints:
                BoxConstraints(maxWidth: ScreenSize.setWidth(context, 0.6)),
            padding: EdgeInsets.symmetric(horizontal: 14, vertical: 8),
            decoration: BoxDecoration(
                color: bubbleChatGrayColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(25),
                  topRight: Radius.circular(25),
                  bottomRight: Radius.circular(25),
                )),
            child: Text(
              data['message'],
              style: bodyLarge(whiteColor),
            ),
          ),
          Text(
            timestampToTime(data['timestamp']),
            style: TextStyle(
                fontSize: 12, fontWeight: FontWeight.w600, color: grayColor500),
            textAlign: TextAlign.end,
          ),
          SizedBox(
            height: 16,
          ),
        ],
      );
    } else {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Container(
            constraints:
                BoxConstraints(maxWidth: ScreenSize.setWidth(context, 0.6)),
            padding: EdgeInsets.symmetric(horizontal: 14, vertical: 8),
            decoration: BoxDecoration(
                color: primaryColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(25),
                  topRight: Radius.circular(25),
                  bottomLeft: Radius.circular(25),
                )),
            child: Text(
              data['message'],
              style: bodyLarge(whiteColor),
            ),
          ),
          Text(
            timestampToTime(data['timestamp']),
            style: TextStyle(
                fontSize: 12, fontWeight: FontWeight.w600, color: grayColor500),
            textAlign: TextAlign.end,
          ),
          SizedBox(
            height: 16,
          ),
        ],
      );
    }
  }
}
