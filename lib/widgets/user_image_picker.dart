import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class userImagePicker extends StatefulWidget {
  const userImagePicker({super.key, required this.onPickedImage});

  final void Function(File pickedImage) onPickedImage;

  @override
  State<userImagePicker> createState(){
  return _userImagePickerState();
  }
}

class _userImagePickerState extends State<userImagePicker> {

  File? _pickedImageFile;

  void _pickImage() async{
   final pickedImage = await ImagePicker().pickImage(source: ImageSource.camera, imageQuality: 60, maxWidth: 150);

   if(pickedImage==null)
   return;

   setState(() {
     _pickedImageFile=File(pickedImage.path);
   });

   widget.onPickedImage(_pickedImageFile!);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 50,
          backgroundColor: Colors.blueGrey.shade200,
          foregroundImage:
          _pickedImageFile!=null? FileImage(_pickedImageFile!): null,

        ),
        TextButton.icon(
          onPressed: _pickImage,
           icon: const Icon(Icons.image),
           label: Text(
            "Add Image",
            style: TextStyle(
              color: Theme.of(context).colorScheme.primary,
              ),
            ),
          ),
      ],
    );
  }
}