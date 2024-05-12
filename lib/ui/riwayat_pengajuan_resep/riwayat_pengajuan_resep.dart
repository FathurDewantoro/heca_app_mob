import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:heca_app_mob/services/auth/auth_service.dart';
import 'package:heca_app_mob/services/resep/resep_service.dart';
import 'package:heca_app_mob/ui/form_pengajuan_resep/form_pengajuan_resep_page.dart';
import 'package:heca_app_mob/ui/list_pengajuan_resep/preview_foto.dart';
import 'package:heca_app_mob/utils/colors.dart';
import 'package:heca_app_mob/utils/formatter.dart';
import 'package:heca_app_mob/utils/my_elevated_button.dart';
import 'package:heca_app_mob/utils/screen_size.dart';
import 'package:heca_app_mob/utils/text_style.dart';
import 'package:iconly/iconly.dart';
import 'package:image_picker/image_picker.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class RiwayatPengajuanResep extends StatefulWidget {
  final String idUser;
  const RiwayatPengajuanResep({super.key, required this.idUser});

  @override
  State<RiwayatPengajuanResep> createState() => _RiwayatPengajuanResepState();
}

class _RiwayatPengajuanResepState extends State<RiwayatPengajuanResep> {
  final ResepService _resepService = ResepService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteBackrground,
      appBar: AppBar(
        toolbarHeight: 64,
        backgroundColor: whiteColor,
        centerTitle: true,
        title: Text(
          "Riwayat Pengajuan Resep",
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
        stream: _resepService.getPengajuanResepStream(),
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
            padding: EdgeInsets.only(left: 20, top: 20, right: 20),
            children: snapshot.data!.docs
                .map((doc) => buildMessageItem(doc))
                .toList(),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        elevation: 0,
        onPressed: () {
          // Tindakan yang ingin dilakukan ketika tombol ditekan
          print('Floating action button pressed');
          Navigator.push(context, MaterialPageRoute(
            builder: (context) {
              return FormPengajuanResepPage();
            },
          ));
        },
        child: Image.asset(
          'assets/images/add_chat_icon.png',
          width: 30,
        ), // Ikona yang ditampilkan di dalam tombol
        backgroundColor: whiteColor, // Warna latar belakang tombol
        shape: CircleBorder(
            side: BorderSide(
                color: borderColor, width: 1.0)), // Menambahkan border radius
      ),
    );
  }

  Widget buildMessageItem(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

    return data['id_user'] != widget.idUser
        ? SizedBox()
        : GestureDetector(
            onTap: () {
              showModalBottomSheet(
                context: context,
                backgroundColor: whiteBackrground,
                isScrollControlled: true,
                builder: (BuildContext context) {
                  return Container(
                    padding: EdgeInsets.only(left: 30, right: 30),
                    height: ScreenSize.setWidth(context, 1.75),
                    child: Column(
                      children: [
                        SizedBox(
                          width: ScreenSize.getWidth(context),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 12, bottom: 8),
                          width: 65,
                          height: 5,
                          decoration: BoxDecoration(
                              color: borderColor,
                              borderRadius: BorderRadius.circular(20)),
                        ),
                        Text(
                          "Detail",
                          style: titleButton(grayColor900),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          // height: ScreenSize.getWidth(context),
                          width: ScreenSize.getWidth(context),
                          padding: EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: whiteColor,
                            borderRadius: BorderRadius.circular(14),
                            border: Border.all(color: borderColor),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Data Pengajuan Resep",
                                style: titleAppBar(grayColor700),
                              ),
                              Divider(
                                color: borderColor,
                                height: 36,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Nama",
                                    style: titleButton(grayColor700),
                                  ),
                                  Text(
                                    data['nama'],
                                    style: titleMedium(grayColor500),
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Keluhan",
                                    style: titleButton(grayColor700),
                                  ),
                                  Text(
                                    data['keluhan'],
                                    style: titleMedium(grayColor500),
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Tanggal Pengajuan",
                                    style: titleButton(grayColor700),
                                  ),
                                  Text(
                                    timestampToDate(data['timestamp']),
                                    style: titleSmall(grayColor500),
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Keterangan",
                                    style: titleButton(grayColor700),
                                  ),
                                  SizedBox(
                                    height: 4,
                                  ),
                                  Text(
                                    data['keterangan'],
                                    style: bodyMedium(grayColor500),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 8,
                                  )
                                ],
                              ),
                              Divider(
                                color: borderColor,
                                height: 40,
                              ),
                              Text(
                                "Balasan Resep Dari Dokter",
                                style: titleButton(grayColor700),
                              ),
                              SizedBox(
                                height: 4,
                              ),
                              data['url_foto'] == null
                                  ? Text("Belum ada resep foto dari dokter")
                                  : Image.network(
                                      data['url_foto'],
                                      height: ScreenSize.setWidth(context, 0.3),
                                    ),
                              SizedBox(
                                height: 4,
                              ),
                              data['url_foto'] == null
                                  ? SizedBox()
                                  : MyElevatedButton(
                                      onPressed: () {
                                        Navigator.push(context,
                                            MaterialPageRoute(
                                          builder: (context) {
                                            return PreviewFotoResep(
                                                url: data['url_foto']);
                                          },
                                        ));
                                      },
                                      child: Text(
                                        "Lihat Foto Resep",
                                        style: bodySmall(whiteColor),
                                      ),
                                      borderRadius: BorderRadius.circular(8),
                                      height: 30)
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              );
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 24),
              margin: EdgeInsets.only(bottom: 24),
              decoration: BoxDecoration(
                color: whiteColor,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: borderColor),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 50,
                        height: 50,
                        padding: EdgeInsets.all(12),
                        decoration: BoxDecoration(
                            color: whiteColor,
                            border: Border.all(color: borderColor),
                            borderRadius: BorderRadius.circular(50)),
                        child: Image.asset(
                          'assets/images/riwayat_icon.png',
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Riwayat",
                            style: titleButton(grayColor900),
                          ),
                          Text(
                            "Pengajuan Resep",
                            style: bodyLarge(grayColor500),
                          )
                        ],
                      )
                    ],
                  ),
                  Text(
                    timestampToDate(data['timestamp']),
                    style: bodyLarge(grayColor500),
                  )
                ],
              ),
            ),
          );
  }
}
