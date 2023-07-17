import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_chats_appss/Screens/auth_screen.dart';

class UserImagePicker extends StatefulWidget {
  final Function(File) imageUriPath;
  const UserImagePicker({Key? key, required this.imageUriPath}) : super(key: key);

  @override
  State<UserImagePicker> createState() => _UserImagePickerState();
}

class _UserImagePickerState extends State<UserImagePicker> {

  var imageURI;
  final ImagePicker imagePicker = ImagePicker();

// To get photo with camera.
  Future<void> getImageFromCamera() async {
    XFile? pickedFile = await imagePicker.pickImage(
        source: ImageSource.camera,
        maxWidth: 150,imageQuality: 50);

    if (pickedFile == null) {
      return;
    }//Update the image variable for rebuild.
    setState(() {
      //Convert the PickedFile type to a File object
    imageURI = File(pickedFile.path);
    });
    widget.imageUriPath(File(pickedFile.path));

  }


  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 40.0,
          backgroundImage: (imageURI == null)
              ? NetworkImage(
            'https://movastore.sgp1.digitaloceanspaces.com/comnostalgiaselfiebeautycamera/appimage/nostalgia-camera-app-image-Z2T6K.png',
          )
              : FileImage(imageURI) as ImageProvider,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 95.0),
          child: Row(
            children: [
              Icon(Icons.image, color: Theme.of(context).colorScheme.primary,),
              TextButton(child: Text('Choose image'),onPressed: getImageFromCamera,),
            ],
          ),
        ),
      ],
    );
  }
}




