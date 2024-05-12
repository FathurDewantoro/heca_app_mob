import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:heca_app_mob/services/auth/auth_service.dart';
import 'package:heca_app_mob/services/shared/shared_preferences.dart';
import 'package:heca_app_mob/services/user/user_service.dart';
import 'package:heca_app_mob/ui/jadwal_dokter/jadwal_dokter_page.dart';
import 'package:heca_app_mob/ui/list_pengajuan_resep/list_pengajuan_resep.dart';
import 'package:heca_app_mob/ui/riwayat_pengajuan_resep/riwayat_pengajuan_resep.dart';
import 'package:heca_app_mob/utils/colors.dart';
import 'package:heca_app_mob/utils/screen_size.dart';
import 'package:heca_app_mob/utils/text_style.dart';
import 'package:iconly/iconly.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String nama = "";
  String role = "";
  String idUser = "";

  UserService _userService = UserService();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserProfile();
  }

  getUserProfile() async {
    final authService = AuthService();
    idUser = (await MySharedPreferences().readIdUser())!;
    nama = (await authService.getDisplayName(idUser))!;
    print("100 | $runtimeType | User Name : ${nama}");

    var data = await _userService.getUserData(idUser);
    role = data['role'];
    print("Role login : $role");
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 30, right: 30, top: 80),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Halo, $nama !",
                      style: titleLarge(whiteColor),
                    ),
                    Text(
                      "Apa kabarmu hari ini",
                      style: bodyLarge(whiteColor),
                    ),
                  ],
                ),
                Container(
                  decoration: BoxDecoration(
                      color: whiteColor,
                      borderRadius: BorderRadius.circular(50)),
                  width: 50,
                  height: 50,
                  child: Icon(
                    IconlyBold.profile,
                    color: primaryColor,
                    size: 30,
                  ),
                )
              ],
            ),
          ),
          Container(
            decoration: BoxDecoration(
                color: whiteBackrground,
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(30),
                    topLeft: Radius.circular(30))),
            height: ScreenSize.setHeight(context, 0.71),
            width: ScreenSize.getWidth(context),
            child: Padding(
              padding: const EdgeInsets.all(30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 18,
                  ),
                  Text(
                    "Menu Utama",
                    style: titleLarge(primaryColor),
                  ),
                  role == "dokter"
                      ? Column(
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.push(context, MaterialPageRoute(
                                  builder: (context) {
                                    return ListPengajuanResepPage();
                                  },
                                ));
                              },
                              child: Container(
                                margin: EdgeInsets.only(top: 30),
                                padding: EdgeInsets.only(left: 20),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(14),
                                  gradient: LinearGradient(
                                    stops: [0.35, 0.9],
                                    begin: Alignment
                                        .centerLeft, // Start from the left
                                    end: Alignment
                                        .centerRight, // End at the right (horizontal gradient)
                                    colors: [
                                      primaryColor,
                                      whiteBackrground
                                    ], // Blue to white colors
                                  ),
                                ),
                                width: ScreenSize.getWidth(context),
                                height: 100,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          "Pengajuan Resep",
                                          style: titleLarge(whiteColor),
                                        ),
                                        Text(
                                          "Daftar pengajuan resep",
                                          style: bodyLarge(whiteColor),
                                        ),
                                      ],
                                    ),
                                    Image.asset('assets/images/resep_icon.png')
                                  ],
                                ),
                              ),
                            )
                          ],
                        )
                      : Column(
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.push(context, MaterialPageRoute(
                                  builder: (context) {
                                    return JadwalDokterPage();
                                  },
                                ));
                              },
                              child: Container(
                                margin: EdgeInsets.only(top: 30),
                                padding: EdgeInsets.only(left: 20),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(14),
                                  gradient: LinearGradient(
                                    stops: [0.35, 0.9],
                                    begin: Alignment
                                        .centerLeft, // Start from the left
                                    end: Alignment
                                        .centerRight, // End at the right (horizontal gradient)
                                    colors: [
                                      primaryColor,
                                      whiteBackrground
                                    ], // Blue to white colors
                                  ),
                                ),
                                width: ScreenSize.getWidth(context),
                                height: 100,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          "Konsultasi",
                                          style: titleLarge(whiteColor),
                                        ),
                                        Text(
                                          "Chat & Jadwal Dokter",
                                          style: bodyLarge(whiteColor),
                                        ),
                                      ],
                                    ),
                                    Image.asset(
                                        'assets/images/konsultasi_icon.png')
                                  ],
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(context, MaterialPageRoute(
                                  builder: (context) {
                                    return RiwayatPengajuanResep(
                                      idUser: idUser,
                                    );
                                  },
                                ));
                              },
                              child: Container(
                                margin: EdgeInsets.only(top: 30),
                                padding: EdgeInsets.only(left: 20),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(14),
                                  gradient: LinearGradient(
                                    stops: [0.35, 0.9],
                                    begin: Alignment
                                        .centerLeft, // Start from the left
                                    end: Alignment
                                        .centerRight, // End at the right (horizontal gradient)
                                    colors: [
                                      primaryColor,
                                      whiteBackrground
                                    ], // Blue to white colors
                                  ),
                                ),
                                width: ScreenSize.getWidth(context),
                                height: 100,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          "Resep Dokter",
                                          style: titleLarge(whiteColor),
                                        ),
                                        Text(
                                          "Riwayat & Pengajuan",
                                          style: bodyLarge(whiteColor),
                                        ),
                                      ],
                                    ),
                                    Image.asset('assets/images/resep_icon.png')
                                  ],
                                ),
                              ),
                            )
                          ],
                        )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
