import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:heca_app_mob/services/auth/auth_service.dart';
import 'package:heca_app_mob/ui/base/base_page.dart';
import 'package:heca_app_mob/ui/register/register_page.dart';
import 'package:heca_app_mob/utils/colors.dart';
import 'package:heca_app_mob/utils/flushbar.dart';
import 'package:heca_app_mob/utils/my_elevated_button.dart';
import 'package:heca_app_mob/utils/screen_size.dart';
import 'package:heca_app_mob/utils/text_style.dart';
import 'package:iconly/iconly.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool _obsPassword = true;
  final FocusNode _focusNode = FocusNode();
  final FocusNode _focusNode2 = FocusNode();

  void login() async {
    final authService = AuthService();

    try {
      await authService.signInWithEmailPassword(
          emailController.text, passwordController.text);
      FlushbarCustom(context, "Anda berhasil login");
    } catch (e) {
      FlushbarCustomError(context, e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/images/logo/logo-primary.png',
            width: ScreenSize.setWidth(context, 0.24),
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
                        'Email',
                        textAlign: TextAlign.start,
                        style: TextStyle(fontWeight: FontWeight.w500),
                      ),
                    ),
                    TextFormField(
                      focusNode: _focusNode,
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
                      focusNode: _focusNode2,
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
                    Container(
                      margin: EdgeInsets.only(top: 14),
                      width: ScreenSize.getWidth(context),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(
                            builder: (context) {
                              return RegisterPage();
                            },
                          ));
                        },
                        child: Text(
                          "Belum memiliki akun ?",
                          style: TextStyle(
                            fontSize: 14,
                            color: primaryColor,
                            decoration: TextDecoration.underline,
                            decorationColor: primaryColor,
                          ),
                          textAlign: TextAlign.end,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    MyElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          _focusNode.unfocus();
                          _focusNode2.unfocus();
                          login();
                          // Navigator.pushReplacement(context, MaterialPageRoute(
                          //   builder: (context) {
                          //     return BasePage();
                          //   },
                          // ));
                        }
                      },
                      child: Text(
                        "Masuk",
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
