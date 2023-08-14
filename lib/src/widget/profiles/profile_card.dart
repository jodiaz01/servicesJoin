import 'package:ServiPro/provider/theme/theme.dart';
import 'package:ServiPro/shared/whatsapp_msg.dart';
import 'package:ServiPro/src/view/profile/watch_profiles_view.dart';
import 'package:ServiPro/src/widget/custon_elevateButton.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfilesCard extends StatelessWidget {
  const ProfilesCard({super.key, required this.themeprovider, required this.avatar, required this.e});

  final ThemeSetting themeprovider;
 final String avatar;
  final e;

  @override
  Widget build(BuildContext context) {
    return e['tipo'] == "F" ?  Container(
      height: 280,
      width: 150,
      decoration: BoxDecoration(
          color: themeprovider.currentTheme.primaryColor,
          borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(8),
              bottomRight: Radius.circular(8),
              topLeft: Radius.circular(28),
              topRight: Radius.circular(0)),
          boxShadow: [
            BoxShadow(
                color: themeprovider.currentTheme.primaryColor,
                blurRadius: 1,
                spreadRadius: 1.7,
                blurStyle: BlurStyle.outer,
                offset: Offset.fromDirection(8,2)),
          ]),
      // color: themeprovider.currentTheme.primaryColor,
      margin: const EdgeInsets.only(top: 2, left: 6, right: 4,bottom: 6),
      child: Stack(
       // crossAxisAlignment: CrossAxisAlignment.center,
        alignment: Alignment.topCenter,
        fit: StackFit.expand,
        children: [
          ClipRRect(

            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(24), bottomLeft: Radius.circular(8), bottomRight:  Radius.circular(8)),
            child: ColorFiltered(
              colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.5), BlendMode.darken),
              child: Image.network(
                avatar,
                // height: 160, // Ajusta la altura según tus necesidades
                // width: 120, // Ajusta el ancho según tus necesidades
                fit: BoxFit.cover,
              ),
            ),
          ),
         Positioned(
           bottom: 0,
           child: Column(
    children:[
            Text(
              e['servicio'].toString(),
              style: GoogleFonts.pacifico(
                  color: Colors.white,
                  fontSize: 16),
            ),
            SizedBox(
              height: 20,
              child: Text(
                'sexo: ${e['sexo']} | edad: ${e['edad']}',
                style:georgia700(Colors.white, 9),
              ),
            ),
            SizedBox(
              height: 20,
              child: Text(
                'ciudad: ${e['ciudad']}',
                style: georgia700(Colors.white, 9),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                CustomElevateButton(
                    function: () async {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => WachtProfileView(
                                    userP: '${e["usuario"]}',
                                  )));
                    },
                    elevations: 0,
                    color: Colors.transparent,//themeprovider.currentTheme.primaryColor.withOpacity(0.5),
                    width: 6,
                    height: 20,
                    icon: const Icon(Icons.info_outline)),
                SizedBox(width: 4,),
                CustomElevateButton(
                    elevations: 0,
                    color: Colors.transparent,
                    icon: const Icon(FontAwesomeIcons.whatsapp),
                    width: 6,
                    height: 20,
                    function: () async {
                      await sendWhatMessage('${e["contacto"]}');
                    }),
              ],
            ),
        ]),
         ),
        ],
      ),
    ):  SizedBox();
  }

TextStyle georgia700(color, double size) {
  return TextStyle(
      fontFamily: 'georgia',
      fontWeight: FontWeight.w700,
      color: color,
      fontSize: size);
}}