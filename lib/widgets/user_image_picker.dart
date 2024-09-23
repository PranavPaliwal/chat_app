import 'package:flutter/material.dart';

class userImagePicker extends StatefulWidget {
  const userImagePicker({super.key});

  @override
  State<userImagePicker> createState(){
  return _userImagePickerState();
  }
}

class _userImagePickerState extends State<userImagePicker> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 30,
          backgroundColor: Colors.blue.shade100,
          foregroundImage: ...,

        );
        TextButton(
          onPressed: (){},
           icon: const Icon(Icons.Image),
           label: Text(
            "Add Image",
            style: TextStyle(
              color: Theme.of(context).ColorScheme.primary;
              ),
            ),
          ),
      ],
    )
  }
}