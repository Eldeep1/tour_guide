
//Technical Dept, should be interface
import 'dart:io';

import 'package:image_picker/image_picker.dart';

class ImagePickerService{
  static final ImagePicker _picker=ImagePicker();

  static Future<File?> uploadImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    return image != null ? File(image.path) : null;
  }
  static Future<File?> captureImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.camera);
    return image != null ? File(image.path) : null;
  }
}
