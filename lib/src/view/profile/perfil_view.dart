import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ServiPro/provider/firebase/crud_fire_user.dart';
import 'package:ServiPro/provider/theme/theme.dart';
import 'package:ServiPro/src/utils/datauser_comun.dart';
import 'package:ServiPro/src/widget/customappbar.dart';
import 'package:ServiPro/src/view/profile/edit_perfil.dart';

class PerfilView extends StatelessWidget {
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
                        placeholder: AssetImage('assets/images/user.png'),
                        image: AssetImage('assets/images/user.png'),
                        width: 50,
                        height: 50,
                      )
                    // .asset(
                    //     'assets/images/user.png',
                    //     width: 50,
                    //     height: 50,
                    //     fit: BoxFit.cover,
                    //   )
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
                      color: themeprovider.currentTheme.secondaryHeaderColor == Colors.black ? themeprovider.currentTheme.secondaryHeaderColor: Colors.white.withOpacity(0.5)
                          ,
                      fontSize: 12,
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
        child: ImageUploader(),
      ),
    );
  }


  // String userData(DataUSerProvider userProvider, String variable) {
  //   userProvider.userdata.map((e) {
  //     switch (variable) {
  //       case 'usuario':
  //         variable = e['usuario'];
  //         break;
  //       case 'foto':
  //         if (e['foto'] != "N/A") {
  //           variable = e['foto'].last;
  //         } else {
  //           variable = 'N/A';
  //         }
  //
  //         break;
  //       default:
  //         variable = '';
  //         break;
  //     }
  //   }).toList();
  //   return variable;
  // }
}
