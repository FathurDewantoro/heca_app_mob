import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

String timestampToTime(Timestamp timestamp) {
  // Konversi timestamp ke objek DateTime
  DateTime dateTime = timestamp.toDate();

  // Format waktu menggunakan DateFormat
  String formattedTime = DateFormat.Hm().format(dateTime); // Format 'HH:mm'

  return formattedTime;
}

String timestampToDate(Timestamp timestamp) {
  // Konversi timestamp ke objek DateTime
  DateTime dateTime = timestamp.toDate();

  // Format waktu menggunakan DateFormat
  String formattedTime = DateFormat.yMEd().format(dateTime); // Format 'HH:mm'

  return formattedTime;
}
