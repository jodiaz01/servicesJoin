import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:services_joined/provider/firebase/crud_fire_user.dart';
import 'package:services_joined/provider/poster/post_provide.dart';
import 'package:services_joined/provider/theme/theme.dart';
import 'package:services_joined/src/utils/datauser_comun.dart';
import 'package:services_joined/src/widget/custom_input.dart';
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
    if (userProvider.listPelfil.isNotEmpty) {
      users = get_userinformations(userProvider, users);
      nombre = get_userinformations(userProvider, nombre);
      foto = get_userinformations(userProvider, foto);
    }

    int index = 0;

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
        child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: ListView(physics: const BouncingScrollPhysics(), children: [
            Wrap(
              children: _images
                  .map((e) {
                index = index + 1;

                return Container(
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
                              e.path.toString().contains(".mp4")
                                  ? VideoPreviewScreen(videoFile: e)
                                  : Image.file(
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
                                   _removeImage(index - 1);
                                },
                              ),
                            ],
                          ),
                        ),
                      );
                  })
                  .toList(),
            ),
            if (_images.isEmpty)
              Padding(
                padding: const EdgeInsets.all(28.0),
                child: Center(
                    child: Text(
                  "Agrega Fotos & Videos",
                  style: GoogleFonts.aBeeZee(
                      color: themeprovider.currentTheme.primaryColor,
                      fontSize: 22,
                      fontWeight: FontWeight.bold),
                )),
              )
            else
              const SizedBox(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CustomElevateButton(
                  color: themeprovider.currentTheme.primaryColor,
                  height: 44,
                  width: 120,
                  function: _pickVideo,
                  icon: const Icon(Icons.folder_delete_outlined),
                  text: 'Galeria',
                ),
                CustomElevateButton(
                  color: themeprovider.currentTheme.primaryColor,
                  height: 44,
                  width: 120,
                  function: _takePhoto,
                  icon: const Icon(Icons.camera_alt_outlined),
                  text: 'Camara',
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Center(
                child: Text(
              'Completar POST',
              style: GoogleFonts.pacifico(
                  color: themeprovider.currentTheme.primaryColor, fontSize: 22),
            )),
            Center(
              child: FormPost(
                color: themeprovider.currentTheme.primaryColor,
              ),
            )
          ]),
        ),
      ),
    );
  }
  void _removeImage(int index) {
    setState(() {
      _images.removeAt(index);
    });
  }
}

class FormPost extends StatelessWidget {
  final Color color;

  const FormPost({super.key, required this.color});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => PostFormProvider(),
      child: Builder(builder: (context) {
        final provider = Provider.of<PostFormProvider>(context, listen: false);
        return Form(
            autovalidateMode: AutovalidateMode.always,
            key: provider.formkey,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    keyboardType: TextInputType.text,
                    onChanged: (value) => provider.userPost.titulo = value,
                    validator: (value) {
                      if (value == '') {
                        return 'titulo es obligatorio';
                      } else {
                        return null;
                      }
                    },
                    decoration: CustomInput.myInputStyles(
                        context: context,
                        hint: 'Titulo',
                        label: 'Nombre del  Post',
                        icon: Icons.title),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    keyboardType: TextInputType.multiline,
                    maxLines: 3,
                    onChanged: (value) => provider.userPost.titulo = value,
                    validator: (value) {
                      if (value == '') {
                        return 'Describe tu Post es Importante';
                      } else {
                        return null;
                      }
                    },
                    decoration: CustomInput.myInputStyles(
                        context: context,
                        hint: 'Comentario',
                        label: 'Describe Tu Publicacion',
                        icon: Icons.description_outlined),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    onChanged: (value) => provider.userPost.titulo = value,
                    decoration: CustomInput.myInputStyles(
                        context: context,
                        hint: '\$Precio ',
                        label: '\$Precio',
                        icon: Icons.monetization_on),
                  ),
                ),
                Divider(
                  height: 30,
                  color: color.withOpacity(0.5),
                ),
                FloatingActionButton.extended(
                    backgroundColor: color,
                    icon: const Icon(Icons.share),
                    label: const Text('Compartir'),
                    onPressed: () {})
              ],
            ));
      }),
    );
  }
}
