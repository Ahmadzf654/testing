

import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class UploadImage extends StatefulWidget {
  const UploadImage({super.key});

  @override
  State<UploadImage> createState() => _UploadImageState();
}

class _UploadImageState extends State<UploadImage> {
  File? image;
  final _picker = ImagePicker();
  bool showSpinner = false;

  Future getImage()async{
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery, imageQuality: 100);
    if(pickedFile != null){
      image = File(pickedFile.path);
      setState(() {

      });
    } else {
      const Text('No image selected');
    }
  }
  Future<void> uploadImage() async{
    setState(() {
      showSpinner = true;
    });
    var stream = http.ByteStream(image!.openRead());
    stream.cast();
    var length = await image!.length();
    var uri = Uri.parse('https://fakestoreapi.com/products');
    var request = http.MultipartRequest('POST', uri);
    request.fields['title'] = "Static title";
    var multiport = http.MultipartFile('image',
        stream,
        length);
    request.files.add(multiport);
    var response = await request.send();
    if(response.statusCode == 200)
      {
        setState(() {
          showSpinner = false;
        });
        print('Image Uploaded');
      }
    else {
      print('Failed');
      setState(() {
        showSpinner = false;
      });

    }
  }
  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: showSpinner,
      child: Scaffold(
        appBar: AppBar(
          title: const  Text('Upload Image', style: TextStyle(
            fontFamily: 'Times New Roman',
            color: Colors.white,

          ),),

          iconTheme: const  IconThemeData(color: Colors.white),

          backgroundColor: Colors.black,
          actions: [
            IconButton(onPressed: (){
              //Navigator.push(context, MaterialPageRoute(builder: (context) => ()));
            }, icon: const Icon(Icons.navigate_next)),

          ],


        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: (){
                getImage();
              },
              child: Container(
                color: Colors.pink,
                child: image == null ? const Center(child: Text('Pick Image'),) :
                Container(
                  child: Center(child: Image.file(
                      File(image!.path).absolute,
                  height: 100,
                  width: 100,
                  fit: BoxFit.cover,
                    ),

                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 100,
            ),
            GestureDetector(
              onTap: (){
                uploadImage();
              },
              child: Container(
                height: 50,
                width: double.infinity,
                color: Colors.green,
                child: const Center(child: Text('Upload')),
              ),
            )
          ],
        ),
      ),
    );
  }
}
