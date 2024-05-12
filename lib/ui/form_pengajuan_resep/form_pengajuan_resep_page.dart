import 'package:flutter/material.dart';
import 'package:heca_app_mob/services/auth/auth_service.dart';
import 'package:heca_app_mob/services/resep/resep_service.dart';
import 'package:heca_app_mob/utils/colors.dart';
import 'package:heca_app_mob/utils/flushbar.dart';
import 'package:heca_app_mob/utils/my_elevated_button.dart';
import 'package:heca_app_mob/utils/screen_size.dart';
import 'package:heca_app_mob/utils/styles.dart';
import 'package:heca_app_mob/utils/text_style.dart';
import 'package:iconly/iconly.dart';

class FormPengajuanResepPage extends StatefulWidget {
  const FormPengajuanResepPage({super.key});

  @override
  State<FormPengajuanResepPage> createState() => _FormPengajuanResepPageState();
}

class _FormPengajuanResepPageState extends State<FormPengajuanResepPage> {
  TextEditingController namaController = TextEditingController();
  TextEditingController keluhanController = TextEditingController();
  TextEditingController keteranganController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final ResepService _resepService = ResepService();

  sendPengajuanResep() async {
    var userId = await AuthService().getCurrentUser();
    var param = {
      "nama": namaController.text,
      "keluhan": keluhanController.text,
      "keterangan": keteranganController.text,
      "timestamp": DateTime.now(),
      "id_user": userId!.uid,
    };

    await _resepService.sendPengajuanResep(param).then((value) {});
    FlushbarCustom(context, "Berhasil mengajukan resep");
    Future.delayed(Duration(seconds: 2), () {
      // Memanggil Navigator.pop() setelah penundaan
      Navigator.pop(context);
      Navigator.pop(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteBackrground,
      appBar: AppBar(
        toolbarHeight: 64,
        backgroundColor: whiteColor,
        centerTitle: true,
        title: Text(
          "Form Pengajuan Resep",
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
      body: ListView(
        padding: EdgeInsets.only(left: 30, top: 20, right: 30),
        children: [
          Text(
            "Pengajuan Resep",
            style: titleAppBar(grayColor700),
          ),
          Text(
            "Isi formulir dengan lengkap dan detail agar dokter dapat memberikan resep seusai dengan keluhan anda.",
            style: bodyLarge(grayColor500),
          ),
          SizedBox(
            height: 14,
          ),
          Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Nama",
                    style: titleSmall(grayColor700),
                  ),
                  TextFormField(
                    controller: namaController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Form nama harus diisi';
                      }
                      return null;
                    },
                    decoration: InputDecorationCustom("Nama Lengkap"),
                  ),
                  SizedBox(
                    height: 14,
                  ),
                  Text(
                    "Keluhan",
                    style: titleSmall(grayColor700),
                  ),
                  TextFormField(
                    controller: keluhanController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Form keluhan harus diisi';
                      }
                      return null;
                    },
                    decoration: InputDecorationCustom("Keluhan"),
                  ),
                  SizedBox(
                    height: 14,
                  ),
                  Text(
                    "Keterangan",
                    style: titleSmall(grayColor700),
                  ),
                  TextFormField(
                    controller: keteranganController,
                    maxLines: 5,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Form keterangan harus diisi';
                      }
                      return null;
                    },
                    decoration: InputDecorationCustom("Keterangan"),
                  ),
                  Container(
                      margin: EdgeInsets.only(top: 20),
                      width: ScreenSize.getWidth(context),
                      child: Center(
                        child: MyElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              sendPengajuanResep();
                            }
                          },
                          child: Text(
                            "Ajukan",
                            style: titleButton(whiteColor),
                          ),
                          height: 46,
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ))
                ],
              ))
        ],
      ),
    );
  }
}
