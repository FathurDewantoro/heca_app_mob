import 'package:flutter/material.dart';
import 'package:heca_app_mob/services/auth/auth_service.dart';
import 'package:heca_app_mob/services/chat/chat_service.dart';
import 'package:heca_app_mob/ui/chat/chat_page.dart';
import 'package:heca_app_mob/utils/colors.dart';
import 'package:heca_app_mob/utils/my_elevated_button.dart';
import 'package:heca_app_mob/utils/text_style.dart';
import 'package:iconly/iconly.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class JadwalDokterPage extends StatefulWidget {
  const JadwalDokterPage({super.key});

  @override
  State<JadwalDokterPage> createState() => _JadwalDokterPageState();
}

class _JadwalDokterPageState extends State<JadwalDokterPage> {
  final ChatService _chatService = ChatService();
  final AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteBackrground,
      appBar: AppBar(
        toolbarHeight: 64,
        backgroundColor: whiteColor,
        centerTitle: true,
        title: Text(
          "Jadwal Dokter",
          style: titleAppBar(primaryColor),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(IconlyLight.arrow_left_2),
        ),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(1.0), // Tinggi border bottom
          child: Container(
            color: borderColor, // Warna border bottom
            height: 1, // Tinggi border bottom
          ),
        ),
      ),
      body: StreamBuilder(
        stream: _chatService.getUsersStream(),
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
          return ListView(
            padding: EdgeInsets.only(left: 20, right: 20, top: 20),
            children: snapshot.data!.map<Widget>((dataDokter) {
              if (dataDokter["role"] == "dokter") {
                return CardJadwalDokter(
                  dataDokter: dataDokter,
                );
              } else {
                return SizedBox();
              }
            }).toList(),
          );
        },
      ),
    );
  }
}

class CardJadwalDokter extends StatelessWidget {
  Map<String, dynamic> dataDokter;
  CardJadwalDokter({super.key, required this.dataDokter});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      margin: EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        color: whiteColor,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: borderColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    dataDokter['nama'],
                    style: titleButton(grayColor900),
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  Text(
                    dataDokter['spesialis'],
                    style: bodyLarge(grayColor500),
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.access_time_filled_rounded,
                        color: grayColor500,
                        size: 20,
                      ),
                      SizedBox(
                        width: 4,
                      ),
                      Text(
                        dataDokter['waktu_praktik'],
                        style: bodyLarge(grayColor500),
                      )
                    ],
                  )
                ],
              ),
              Container(
                decoration: BoxDecoration(
                  color: whiteColor,
                  borderRadius: BorderRadius.circular(50),
                  border: Border.all(color: borderColor),
                ),
                width: 50,
                height: 50,
                child: Icon(
                  IconlyBold.profile,
                  color: primaryColor,
                  size: 22,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          MyElevatedButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(
                builder: (context) {
                  return ChatPage(
                    receiverId: dataDokter['uid'],
                    senderId: "",
                    userName: dataDokter['nama'],
                    role: "pelanggan",
                  );
                },
              ));
            },
            child: Text(
              "Konsultasi",
              style: titleSmall(whiteColor),
            ),
            height: 30,
            borderRadius: BorderRadius.circular(8),
          )
        ],
      ),
    );
  }
}
