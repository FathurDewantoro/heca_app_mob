import 'package:flutter/material.dart';
import 'package:heca_app_mob/services/auth/auth_service.dart';
import 'package:heca_app_mob/ui/splash/splash_page.dart';
import 'package:heca_app_mob/utils/colors.dart';
import 'package:heca_app_mob/utils/flushbar.dart';
import 'package:heca_app_mob/utils/my_elevated_button.dart';
import 'package:heca_app_mob/utils/popinfo.dart';
import 'package:heca_app_mob/utils/screen_size.dart';
import 'package:heca_app_mob/utils/styles.dart';
import 'package:heca_app_mob/utils/text_style.dart';
import 'package:iconly/iconly.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  bool isLoading = false;
  final _formKey = GlobalKey<FormState>();
  TextEditingController namaController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool _obsPassword = true;

  void register() async {
    setState(() {
      isLoading = true;
    });
    final _auth = AuthService();

    await _auth
        .signUpWithEmailPassword(emailController.text, passwordController.text,
            namaController.text, context)
        .then((value) {});
    FlushbarCustom(context, "Berhasil membuat akun !");
    await Future.delayed(Duration(seconds: 2)).then((value) {});
    setState(() {
      isLoading = false;
    });
    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
      builder: (context) {
        return SplashPage();
      },
    ), (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        backgroundColor: whiteColor,
        leading: IconButton(
          icon: Icon(IconlyLight.arrow_left_2),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Daftar Akun Baru",
              style: titleAppBar(grayColor900),
            ),
            SizedBox(
              width: ScreenSize.setWidth(context, 0.8),
              child: Text(
                "Buat akun anda untuk mendapatkan semua fitur dari HECA Apps.",
                style: bodyLarge(grayColor700),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(bottom: 5),
                        width: ScreenSize.getWidth(context),
                        child: const Text(
                          'Nama',
                          textAlign: TextAlign.start,
                          style: TextStyle(fontWeight: FontWeight.w500),
                        ),
                      ),
                      TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        style: titleMedium(grayColor900),
                        decoration: InputDecorationCustom("Nama Lengkap"),
                        controller: namaController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Nama tidak boleh kosong';
                          }
                          return null;
                        },
                      ),
                      Container(
                        margin: const EdgeInsets.only(bottom: 5, top: 20),
                        width: ScreenSize.getWidth(context),
                        child: const Text(
                          'Email',
                          textAlign: TextAlign.start,
                          style: TextStyle(fontWeight: FontWeight.w500),
                        ),
                      ),
                      TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        style: titleMedium(grayColor900),
                        decoration: InputDecorationEmail(),
                        controller: emailController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Email tidak boleh kosong';
                          }
                          return null;
                        },
                      ),
                      Container(
                        margin: const EdgeInsets.only(bottom: 5, top: 20),
                        width: ScreenSize.getWidth(context),
                        child: const Text(
                          'Password',
                          textAlign: TextAlign.start,
                          style: TextStyle(fontWeight: FontWeight.w500),
                        ),
                      ),
                      TextFormField(
                        obscureText: _obsPassword,
                        keyboardType: TextInputType.text,
                        style: titleMedium(grayColor900),
                        decoration: InputDecorationPassword(),
                        controller: passwordController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Password tidak boleh kosong';
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      isLoading
                          ? MyElevatedButton(
                              onPressed: () {},
                              child: SizedBox(
                                width: ScreenSize.setWidth(context, 0.37),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Mendaftar",
                                      style: titleButton(whiteColor),
                                    ),
                                    SizedBox(
                                      width: 14,
                                    ),
                                    LoadingAnimationWidget.threeArchedCircle(
                                      color: whiteColor,
                                      size: 28,
                                    ),
                                  ],
                                ),
                              ),
                              height: 48,
                              color: primaryDisableColor,
                              borderRadius: BorderRadius.circular(8),
                            )
                          : MyElevatedButton(
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  register();
                                }
                              },
                              child: Text(
                                "Daftar",
                                style: titleButton(whiteColor),
                              ),
                              height: 48,
                              borderRadius: BorderRadius.circular(8),
                            )
                    ],
                  )),
            )
          ],
        ),
      ),
    );
  }

  //toggle change obscure password
  void _toggleObscured() {
    setState(() {
      _obsPassword == true ? _obsPassword = false : _obsPassword = true;
    });
  }

  InputDecoration InputDecorationEmail() {
    return InputDecoration(
      focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: primaryColor)),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: borderColor),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color: errorColor900),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: errorColor900),
      ),
      disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: borderColor)),
      contentPadding: EdgeInsets.all(14),
      hintText: 'Masukkan Email Anda',
      hintStyle: titleMedium(grayColor500),
      border:
          const OutlineInputBorder(borderSide: BorderSide(color: borderColor)),
    );
  }

  InputDecoration InputDecorationPassword() {
    return InputDecoration(
      focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: primaryColor)),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: borderColor),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: errorColor900),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: errorColor900),
      ),
      disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: borderColor)),
      contentPadding: EdgeInsets.all(14),
      hintText: 'Masukkan Password Anda',
      hintStyle: titleMedium(grayColor500),
      border:
          const OutlineInputBorder(borderSide: BorderSide(color: borderColor)),
      suffixIcon: IconButton(
          onPressed: () {
            _toggleObscured();
          },
          icon: Icon(
            _obsPassword ? IconlyLight.hide : IconlyLight.show,
            size: 24,
          )),
    );
  }
}
