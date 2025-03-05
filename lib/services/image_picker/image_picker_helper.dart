  //
  // main.dart

  import 'dart:io';
  import 'package:image_picker/image_picker.dart';
  import 'package:flutter/material.dart';
  import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:tour_guide/core/themes/darkTheme.dart';

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

                onPressed: kIsWeb?null:() {
                  Navigator.of(context).pop(true);
                },
                child: Text("Camera",style: kIsWeb?Theme.of(context).textTheme.bodyMedium?.copyWith(color:freeTextColor.withAlpha(200) ):Theme.of(context).textTheme.titleMedium,),
              ),
              SizedBox(
                height: 20,
              ),
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



  class HomePage extends StatefulWidget {
    const HomePage({Key? key}) : super(key: key);

    @override
    State<HomePage> createState() => _HomePageState();
  }

  class _HomePageState extends State<HomePage> {
    ImagePickerHelper imagePickerHelper=ImagePickerHelper();
    // This is the file that will be used to store the image
    XFile? _image; // Store the selected image



    @override
    Widget build(BuildContext context) {
      return Scaffold(
          appBar: AppBar(
            title: const Text('Kindacode.com'),
          ),
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(35),
              child: Column(children: [
                Center(
                  // this button is used to open the image picker
                  child: ElevatedButton(
                    onPressed: ()async{
                      imagePickerHelper.openImagePicker(context).then((value) {
                        setState(() {
                          _image=value;
                        });
                      },);
                    },
                    child: const Text('Select An Image'),
                  ),
                ),
                const SizedBox(height: 35),
                // The picked image will be displayed here
                Container(
                  alignment: Alignment.center,
                  width: double.infinity,
                  height: 300,
                  color: Colors.grey[300],
                  child:

                  Builder(
                    builder: (context) {
                      if (_image == null) {
                        return Text('No image selected.');
                      } else if (kIsWeb) {
                        return Image.network(_image!.path, fit: BoxFit.cover);
                      } else {
                        return Image.file(File(_image!.path));
                      }
                    },
                  )

                )
              ]),
            ),
          ));
    }
  }