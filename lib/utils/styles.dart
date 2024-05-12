import "package:flutter/material.dart";
import "package:heca_app_mob/utils/text_style.dart";
import "package:iconly/iconly.dart";
import "colors.dart";

BoxDecoration DecorationBorderOnly() {
  return BoxDecoration(
    color: whiteColor,
    border: Border.all(color: borderColor), // Set the border color
    borderRadius: BorderRadius.circular(8.0), // Set the border radius
  );
}

AppBar AppBarCustom(String title) {
  return AppBar(
    backgroundColor: whiteColor,
    centerTitle: false,
    title: Text(
      title,
      style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
    ),
    surfaceTintColor: Colors.transparent,
    bottom: PreferredSize(
      preferredSize: Size.fromHeight(1), // Set the height of the divider
      child: Divider(
        color: borderColor, // Set the color of the divider
        height: 1.0, // Set the thickness of the divider
      ),
    ),
  );
}

BoxShadow containerBoxShadow() {
  return const BoxShadow(
    color: Colors.black12,
    offset: Offset(0, 0.5),
    blurRadius: 0.5,
    spreadRadius: 0,
  );
}

BoxDecoration whiteContainerShadow() {
  return BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(10),
    boxShadow: [containerBoxShadow()],
  );
}

BoxDecoration decorationBorder([Color? backgroundColor]) {
  return BoxDecoration(
      color: backgroundColor ?? whiteColor,
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: borderColor, width: 1));
}

InputDecoration InputDecorationCustom(String hintText) {
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
        borderSide: const BorderSide(color: errorColor900)),
    focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: errorColor900)),
    disabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: borderColor)),
    // contentPadding: EdgeInsets.all(20),
    contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
    hintText: hintText,
    hintStyle: titleMedium(grayColor500),
    fillColor: whiteColor,
    filled: true,
    border:
        const OutlineInputBorder(borderSide: BorderSide(color: borderColor)),
  );
}

InputDecoration InputDecorationCustomPencarian(String hintText) {
  return InputDecoration(
    focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: primaryColor)),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: const BorderSide(color: borderColor),
    ),
    disabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: borderColor)),
    contentPadding: EdgeInsets.all(12),
    hintText: hintText,
    prefixIcon: Icon(
      IconlyLight.search,
      color: grayColor500,
      size: 24,
    ),
    hintStyle: titleMedium(grayColor500),
    fillColor: whiteColor,
    filled: true,
    border:
        const OutlineInputBorder(borderSide: BorderSide(color: borderColor)),
  );
}

InputDecoration InputDecorationCustomPrefix(String hintText, IconData icon) {
  return InputDecoration(
    focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: primaryColor)),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: const BorderSide(color: borderColor),
    ),
    disabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: borderColor)),
    contentPadding: EdgeInsets.all(12),
    hintText: hintText,
    prefixIcon: Icon(
      icon,
      color: grayColor500,
      size: 24,
    ),
    hintStyle: titleMedium(grayColor500),
    fillColor: whiteColor,
    filled: true,
    border:
        const OutlineInputBorder(borderSide: BorderSide(color: borderColor)),
  );
}

InputDecoration InputDecorationCustomSuffix(String hintText, IconData icon,
    [bool? enable]) {
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
        borderSide: const BorderSide(color: errorColor900)),
    focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: errorColor900)),
    disabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: borderColor)),
    contentPadding: EdgeInsets.all(12),
    hintText: hintText,
    enabled: enable ?? true,
    suffixIcon: Icon(
      icon,
      color: grayColor500,
      size: 24,
    ),
    hintStyle: titleMedium(grayColor500),
    fillColor: whiteColor,
    filled: true,
    border:
        const OutlineInputBorder(borderSide: BorderSide(color: borderColor)),
  );
}

extension StringExtensions on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${this.substring(1)}";
  }
}
