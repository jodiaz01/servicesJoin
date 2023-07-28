
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:services_joined/provider/firebase/crud_fire_user.dart';
import 'package:services_joined/provider/theme/theme.dart';
import 'package:services_joined/src/utils/datauser_comun.dart';
import 'package:services_joined/src/widget/customappbar.dart';
import 'package:services_joined/src/widget/custon_elevateButton.dart';
import 'package:services_joined/src/widget/videopreview/videopreviews.dart';

class PostView extends StatefulWidget {
  const PostView({super.key});

  @override
  State<PostView> createState() => _PostViewState();
}

class _PostViewState extends State<PostView> {
  List<File> _images = [];

  Future<void> _pickImages() async {
    List<XFile>? pickedImages = await ImagePicker().pickMultiImage();
    setState(() {
      pickedImages.map((image) {
        _images.add(File(image.path));
        return File(image.path);
      }).toList();
    });
  }

  Future<void> _takePhoto() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.camera);

    if (pickedFile != null) {
      setState(() {
        _images.add(File(pickedFile.path));


      });
    }
  }
  Future<void> _pickVideo() async {
    List<XFile>? pickedImages = await ImagePicker().pickMultipleMedia();
    setState(() {
      pickedImages.map((image) {
        _images.add(File(image.path));
        return File(image.path);
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    final themeprovider = Provider.of<ThemeSetting>(context);
    final userProvider = Provider.of<FirebaseProvider>(context);
    String users = "usuario";
    String foto = "foto";
    String nombre = "nombre";
    if(userProvider.listPelfil.isNotEmpty) {
      users = get_userinformations(userProvider, users);
      nombre = get_userinformations(userProvider, nombre);
      foto = get_userinformations(userProvider, foto);
    }
    return Scaffold(
      backgroundColor: themeprovider.currentTheme.primaryColor,
      body: CustomAppbar(
        elevation: 0.15,
        title: Row(
          children: [
            ClipRRect(
                borderRadius: BorderRadius.circular(30),
                child: foto == ''
                    ? const FadeInImage(
                  fadeInDuration: Duration(seconds: 4),
                  placeholder: AssetImage('assets/images/24-hours.png'),
                  image: AssetImage('assets/images/user.png'),
                  width: 50,
                  height: 50,
                )

                    : Image.network(
                  foto,
                  width: 50,
                  height: 50,
                  fit: BoxFit.cover,
                )),
            const SizedBox(
              width: 15,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // LocalDataUser().leeCliente(''),
                  Text(users,
                      style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontFamily: "georgia")),
                  Text(
                    nombre,
                    style: TextStyle(
                      color: themeprovider.currentTheme.secondaryHeaderColor
                          .withOpacity(0.5),
                      fontSize: 12,
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
        child: ListView(
          children:[
            Wrap(
            children: _images.map((e) =>
                Container(

                  // height: 100,
                  width: 150,
                  decoration: BoxDecoration(
                    color: themeprovider.currentTheme.primaryColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: const EdgeInsets.all(2),
                  margin: const EdgeInsets.all(8),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Column(
                      children: [
                        Text(
                          '${e.path.split('/').last}',
                          style: const TextStyle(color: Colors.white),
                        ),
                        e.path.toString().contains(".mp4") ?

                        VideoPreviewScreen(videoFile: e)  :
                        Image.file(
                          e,
                          width: 180,
                          height: 100,
                          fit: BoxFit.fill,
                        ),
                        IconButton(
                          icon: Icon(
                            Icons.highlight_remove_sharp,
                            color: Colors.white.withOpacity(0.7),
                            size: 32,
                          ),
                          onPressed: () {
                           // _removeImage(index - 1);
                          },
                        ),
                      ],
                    ),
                  ),
                )

            ).toList(),
          ),

            CustomElevateButton(
              color: themeprovider.currentTheme.primaryColor,
              height: 44,
              width: 120,
              function:
              _pickVideo,
              icon: Icon(Icons.camera_alt_outlined),
              text: 'Camara',
            ),
        ]),
      ),
    );
  }
}
