import 'package:flutter/material.dart';
import 'package:heca_app_mob/ui/base/home/home_screen.dart';
import 'package:heca_app_mob/ui/base/pesan/pesan_screen.dart';
import 'package:heca_app_mob/ui/base/profile/profile_screen.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:heca_app_mob/utils/colors.dart';
import 'package:heca_app_mob/utils/text_style.dart';
import 'package:iconly/iconly.dart';

class BasePage extends StatefulWidget {
  const BasePage({super.key});

  @override
  State<BasePage> createState() => _BasePageState();
}

class _BasePageState extends State<BasePage> {
  int _selectedIndex = 1;
  static const List<Widget> _widgetOptions = <Widget>[
    PesanScreen(),
    HomeScreen(),
    ProfileScreen()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
              icon: DefaultIcon(IconlyLight.chat, "Pesan"),
              activeIcon: ActiveIcon(IconlyBold.chat, "Pesan"),
              label: "Analytic"),
          BottomNavigationBarItem(
              icon: DefaultIcon(IconlyLight.home, "Home"),
              activeIcon: ActiveIcon(IconlyBold.home, "Home"),
              label: "Analytic"),
          BottomNavigationBarItem(
              icon: DefaultIcon(IconlyLight.profile, "Profile"),
              activeIcon: ActiveIcon(IconlyBold.profile, "Profile"),
              label: "Analytic"),
        ],
        currentIndex: _selectedIndex,
        selectedFontSize: 0,
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
        backgroundColor: whiteColor,
      ),
    );
  }

  Padding DefaultIcon(IconData iconData, String title) {
    return Padding(
      padding: const EdgeInsets.only(top: 8, bottom: 8),
      child: SizedBox(
        height: 50,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(
              iconData,
              size: 24,
            ),
            Text(
              title,
              style: bodyLarge(grayColor500),
            )
          ],
        ),
      ),
    );
  }

  Padding ActiveIcon(IconData iconData, String title) {
    return Padding(
      padding: const EdgeInsets.only(top: 8, bottom: 8),
      child: SizedBox(
        height: 50,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(
              iconData,
              color: primaryColor,
              size: 24,
            ),
            Text(
              title,
              style: bodyLarge(primaryColor),
            )
          ],
        ),
      ),
    );
  }
}
