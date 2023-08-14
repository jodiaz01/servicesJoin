import 'dart:io';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:ServiPro/provider/firebase/crud_fire_user.dart';
import 'package:ServiPro/provider/theme/theme.dart';
import 'package:ServiPro/provider/user/detail_profile_provider.dart';
import 'package:ServiPro/src/utils/datauser_comun.dart';
import 'package:ServiPro/src/view/login/profile_detalles_view.dart';
import 'package:ServiPro/src/widget/alertas.dart';
import 'package:ServiPro/src/widget/custon_elevateButton.dart';

class ImageUploader extends StatefulWidget {
  @override
  _ImageUploaderState createState() => _ImageUploaderState();
}

class _ImageUploaderState extends State<ImageUploader> {
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

  @override
  Widget build(BuildContext context) {
    final themeprovider = Provider.of<ThemeSetting>(context);
    final fireProvider = Provider.of<FirebaseProvider>(context);

    final userProvider = Provider.of<DetailsFormProvider>(context);

    String docuemnto = '';
    String forenkey = '0';
    String Tipo='';
    if (fireProvider.listPelfil.isNotEmpty) {
      setState(() {
        docuemnto = get_userinformations(fireProvider, 'documento');
        forenkey = get_userinformations(fireProvider, 'uid');
        Tipo = get_userinformations(fireProvider,'tipo');
      });

      // print('La Lave del usuario almacendado es ----------------------------------------$forenkey');
    }
    int index = 0;
    return ListView(
      physics: const BouncingScrollPhysics(),
      // crossAxisAlignment: CrossAxisAlignment.start,
      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        DetailsPefilView(
          userProvider: userProvider,tipo: Tipo,
        ),
        const SizedBox(
          height: 12,
        ),
        Wrap(
            children: _images.map((e) {
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
                      _removeImage(index - 1);
                    },
                  ),
                ],
              ),
            ),
          );
        }).toList()),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            FloatingActionButton.extended(
              label: Text("Galeria"),
              backgroundColor: themeprovider.currentTheme.primaryColor,
              icon: const Icon(Icons.file_copy_outlined),
              onPressed: _pickImages,
            ),
            CustomElevateButton(
              color: themeprovider.currentTheme.primaryColor,
              height: 44,
              width: 120,
              function: _takePhoto,
              icon: Icon(Icons.camera_alt_outlined),
              text: 'Camara',
            ),
            CustomElevateButton(
              color: themeprovider.currentTheme.primaryColor,
              height: 44,
              width: 100,
              function: () async {
                bool continuar = false;
                // bool isfmvalid = userProvider.validateForm();
                //if (isfmvalid) {

                if (index < 2) {
                  CustomAlert(
                      (context),
                      '2 Imagens minimas ',
                      const Text(
                          'se requieren 2 o mas imagenes almenos una de perfil y otra de lado  '),
                      'N/A',
                      true);
                  return;
                } else {
                  bool isOk = await fireProvider.completePerfil(
                      userProvider.userDatails, (context), int.parse(forenkey));
                  // bool isOk =
                  await fireProvider.EdidPerfilWithFiles(
                      _images.toList(), docuemnto);

                  if (isOk) {
                    get_userinformations(fireProvider, 'foto');
                    CustomAlert(
                        (context),
                        'Creado',
                        const Text(
                            'Perfil Actualizado Correctamente Puede Regresar A inicio'),
                        'N/A',
                        true);
                  }
                }
              },
              text: 'Editar',
              icon: const Icon(FontAwesomeIcons.edit),
            ),
          ],
        ),
        const SizedBox(
          height: 20,
        ),
      ],
    );
  }

  void _removeImage(int index) {
    setState(() {
      _images.removeAt(index);
    });
  }
}
