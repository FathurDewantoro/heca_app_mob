import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:heca_app_mob/services/auth/auth_service.dart';
import 'package:heca_app_mob/services/shared/shared_preferences.dart';
import 'package:heca_app_mob/services/user/user_service.dart';
import 'package:heca_app_mob/ui/splash/splash_page.dart';
import 'package:heca_app_mob/utils/colors.dart';
import 'package:heca_app_mob/utils/flushbar.dart';
import 'package:heca_app_mob/utils/screen_size.dart';
import 'package:heca_app_mob/utils/text_style.dart';
import 'package:iconly/iconly.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String nama = "";
  String email = "";

  UserService _userService = UserService();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserProfile();
  }

  getUserProfile() async {
    var idUser = (await MySharedPreferences().readIdUser())!;
    var data = await _userService.getUserData(idUser);
    nama = data['nama'];
    email = data['email'];
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteBackrground,
      appBar: AppBar(
        backgroundColor: whiteBackrground,
        title: Text(
          "Profile Saya",
          style: titleAppBar(primaryColor),
        ),
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            margin: EdgeInsets.only(top: 30),
            decoration: BoxDecoration(
                border: Border.all(color: borderColor),
                color: whiteColor,
                borderRadius: BorderRadius.circular(50)),
            width: 90,
            height: 90,
            child: Icon(
              IconlyBold.profile,
              color: primaryColor,
              size: 40,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            nama,
            style: titleLarge(primaryColor),
          ),
          Text(
            email,
            style: bodyLarge(grayColor500),
          ),
          SizedBox(
            width: ScreenSize.getWidth(context),
          ),
          Padding(
            padding: const EdgeInsets.all(30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: ScreenSize.getWidth(context),
                ),
                Text(
                  "Pusat Bantuan",
                  style: titleAppBar(primaryColor),
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(
                          IconlyLight.setting,
                          color: primaryColor,
                        ),
                        SizedBox(
                          width: 6,
                        ),
                        Text(
                          "Pengaturan",
                          style: titleMedium(grayColor900),
                        )
                      ],
                    ),
                    Icon(IconlyLight.arrow_right_2)
                  ],
                ),
                SizedBox(
                  height: 26,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(
                          IconlyLight.shield_done,
                          color: primaryColor,
                        ),
                        SizedBox(
                          width: 6,
                        ),
                        Text(
                          "Bantuan",
                          style: titleMedium(grayColor900),
                        )
                      ],
                    ),
                    Icon(IconlyLight.arrow_right_2)
                  ],
                ),
                SizedBox(
                  height: 26,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(
                          IconlyLight.info_square,
                          color: primaryColor,
                        ),
                        SizedBox(
                          width: 6,
                        ),
                        Text(
                          "Pengaturan",
                          style: titleMedium(grayColor900),
                        )
                      ],
                    ),
                    Icon(IconlyLight.arrow_right_2)
                  ],
                ),
                SizedBox(
                  height: 26,
                ),
                GestureDetector(
                  onTap: () {
                    FlushbarCustomError(context, "Anda berhasil logout");
                    signOut();
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(
                            IconlyLight.logout,
                            color: Colors.red[700]!,
                          ),
                          SizedBox(
                            width: 6,
                          ),
                          Text(
                            "Keluar",
                            style: titleMedium(Colors.red[700]!),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  void signOut() async {
    final authService = AuthService();

    authService.signOut();
  }
}
