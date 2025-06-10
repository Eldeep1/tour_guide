import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';

class SendingImageTemp extends StatelessWidget {
  const SendingImageTemp({super.key});

  @override
  Widget build(BuildContext context) {

    return const Placeholder();
  }

  Future<void> uploadingPicture () async {
    final image=ImagePicker();
    XFile? result = await image.pickImage(source: ImageSource.gallery);
    File file = File(result!.path);
    Dio dio=Dio();
    dio.post(
      "",
      data: {
        "file":MultipartFile.fromFile(
            file.path,
            filename: basename(file.path),
        )
      }
    );
}
}
