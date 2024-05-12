import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';

import 'package:heca_app_mob/utils/colors.dart';

void FlushbarCustom(context, text) {
  Flushbar(
    message: text,
    icon: Icon(
      Icons.info_outline,
      size: 28.0,
      color: primaryColor,
    ),
    flushbarPosition: FlushbarPosition.TOP,
    margin: EdgeInsets.all(20),
    borderRadius: BorderRadius.circular(8),
    duration: Duration(seconds: 3),
    leftBarIndicatorColor: primaryColor,
  )..show(context);
}

void FlushbarCustomError(context, text) {
  Flushbar(
    message: text,
    icon: Icon(
      Icons.info_outline,
      size: 28.0,
      color: errorColor900,
    ),
    flushbarPosition: FlushbarPosition.TOP,
    margin: EdgeInsets.all(20),
    borderRadius: BorderRadius.circular(8),
    duration: Duration(seconds: 3),
    leftBarIndicatorColor: errorColor900,
  )..show(context);
}
