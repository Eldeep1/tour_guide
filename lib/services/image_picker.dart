
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerHelper{
  File? image;

  Future<XFile?> openImagePicker(context) async {

    bool? isCamera = await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.amberAccent.shade200,
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [

            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop(false);
              },
              child: Text("gallery ",style: Theme.of(context).textTheme.titleMedium,),
            ),
          ],
        ),
      ),
    );

    if (isCamera == null) return null;

    XFile? file = await ImagePicker()
        .pickImage(source: isCamera ? ImageSource.camera : ImageSource.gallery);
    image = File(file!.path);


    return file;
  }

}

