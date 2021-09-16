import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';

class ImgField extends StatelessWidget {
  final File? arquivo;
  final String? img64;

  const ImgField({Key? key, this.img64, this.arquivo}) : super(key: key);

  Image imgCheck(img64, arquivo) {
    

    if (img64 == null && arquivo == null) {
      return Image(image: AssetImage('assets/img_error.png'));
    } else if (arquivo != null) {
      return Image.file(arquivo, fit: BoxFit.contain);
    } else {
      var bytes = base64.decode(img64.toString());
      return Image.memory(bytes);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8),
      child: Center(
        child: SizedBox(
          width: 200,
          height: 200,
          child: ClipRRect(
              borderRadius: BorderRadius.circular(12.0),
              child: imgCheck(img64, arquivo)),
        ),
      ),
    );
  }
}
