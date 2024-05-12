import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:heca_app_mob/utils/colors.dart';
import 'package:heca_app_mob/utils/flushbar.dart';
import 'package:heca_app_mob/utils/text_style.dart';
import 'package:http/http.dart';
import 'package:iconly/iconly.dart';

class PreviewFotoResep extends StatefulWidget {
  final String url;
  const PreviewFotoResep({super.key, required this.url});

  @override
  State<PreviewFotoResep> createState() => _PreviewFotoResepState();
}

class _PreviewFotoResepState extends State<PreviewFotoResep> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          GestureDetector(
            onTap: () {
              FlushbarCustom(
                  context, "Tunggu sebentar, resep dalam proses pengunduhan.");
              // _saveImage(context);
              // saveNetworkImage();
              saveNetworkImageToDownloadFolder();
            },
            child: Row(
              children: [
                Text(
                  "Simpan Resep",
                  style: titleButton(grayColor700),
                ),
                SizedBox(
                  width: 6,
                ),
                Icon(IconlyLight.download),
                SizedBox(
                  width: 14,
                ),
              ],
            ),
          )
        ],
      ),
      body: Center(
        child: Image.network(widget.url),
      ),
    );
  }

  Future<String> saveNetworkImageToDownloadFolder() async {
    final response = await get(Uri.parse(widget.url));

    if (response.statusCode == 200) {
      final bytes = response.bodyBytes;

      // Dapatkan direktori download system
      final downloadFolder = Directory('/storage/emulated/0/Download');

      // Buat nama file gambar
      String fileName = 'resep.jpg';
      String filePath = '${downloadFolder.path}/$fileName';

      // Check if file already exists
      int count = 1;
      while (File(filePath).existsSync()) {
        fileName = 'resep_$count.jpg'; // Tambahkan nomor di belakang nama file
        filePath = '${downloadFolder.path}/$fileName';
        count++;
      }

      // Simpan gambar ke folder download
      await File(filePath).writeAsBytes(bytes);

      print(filePath);

      FlushbarCustom(
          context, "Berhsail menyimpan resep didalm folder Download");

      return filePath;
    } else {
      FlushbarCustomError(context, "Failed to download image");
      throw Exception('Failed to download image');
    }
  }
}
