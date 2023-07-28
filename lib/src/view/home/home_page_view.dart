import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:elegant_notification/elegant_notification.dart';
import 'package:elegant_notification/resources/arrays.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:services_joined/provider/firebase/crud_fire_user.dart';
import 'package:services_joined/provider/theme/theme.dart';
import 'package:services_joined/shared/whatsapp_msg.dart';
import 'package:services_joined/src/utils/appcolor.dart';
import 'package:services_joined/src/utils/datauser_comun.dart';
import 'package:services_joined/src/view/profile/watch_profiles_view.dart';
import 'package:services_joined/src/widget/aguila_container.dart';
import 'package:services_joined/src/widget/animate_bottonav.dart';
import 'package:services_joined/src/widget/customappbar.dart';
import 'package:services_joined/src/widget/custon_elevateButton.dart';
import 'package:services_joined/src/widget/postcard/custom_post.dart';
import 'package:services_joined/src/widget/team_creator.dart';

class HomePageView extends StatelessWidget {
  const HomePageView({super.key});

  @override
  Widget build(BuildContext context) {
    GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();
    final themeprovider = Provider.of<ThemeSetting>(context);
    final cureenrthemcolor = themeprovider.currentTheme.primaryColor;
    String tipo = '';
    String foto = '';
    String Completdado = '';
    Color color = themeprovider.currentTheme.primaryColor;
    Color colorbac = Colors.amber;
    if (cureenrthemcolor == AppColors.aguilaColors) {
      colorbac = Colors.amber;
    }
    final screenSize = MediaQuery.of(context).size;
    FirebaseProvider dataUser = Provider.of<FirebaseProvider>(context);

    String user = get_userinformations(dataUser, 'usuario');
    tipo = get_userinformations(dataUser, 'tipo');
    foto = get_userinformations(dataUser, 'foto');
    Completdado = get_userinformations(dataUser, 'perfil');

    String avatar = '';
    return Scaffold(
      bottomNavigationBar:
          CustomNavigationBar(0, _bottomNavigationKey, color, colorbac,foto),
      backgroundColor: themeprovider.currentTheme.primaryColor,
      body: CustomAppbar(
          elevation: getCurrentTheme(cureenrthemcolor) ? 0.2 : 0.09,

          // title: Text('Services Joined'),
          //
          icon: cureenrthemcolor == AppColors.aguilaColors
              ? AguilaThemeContainer()
              : cureenrthemcolor == AppColors.yankeeblue
                  ? Stack(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 15),
                          child: CustomPaint(
                            size: const Size(140, 140),
                            painter: TeamLogoPainter(
                                'NY', themeprovider.currentTheme.secondaryHeaderColor.withOpacity(0.6)),
                          ),
                        ),
                        Positioned(
                          top: 15,
                          //right: 12,
                          left: 38,

                          child: SizedBox(height:120,)
                        ),
                      ],
                    )
                  : Padding(
                      padding: const EdgeInsets.only(left: 0, right: 250),
                      child: Text(
                        'Hi..! $user',
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontFamily: 'Georgia'),
                      ),
                    ),
          child: RefreshIndicator(
              color: Colors.white70,
              backgroundColor: themeprovider.currentTheme.primaryColor,
              onRefresh: () async {
                await dataUser.iniciaData();

                dataUser.listPelfil;
              },
              child: ListView(
                padding:const  EdgeInsets.only(top: 0,bottom: 8),
                children: [
                  Completdado == "NO" && tipo == 'F' ?
                      Padding(padding: EdgeInsets.all(20),

                      child:
                      ElegantNotification.info(
                                  notificationPosition: NotificationPosition.center,
                                  // animation: AnimationType.fromTop,
                                  width: screenSize.width,
                                  height: 110,
                                  displayCloseButton: true,
                                  toastDuration: const Duration(seconds: 12),
                                  title: const Text(
                                    "Completar Perfil Para Ver Contenido",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold, fontFamily: 'georgia'),
                                  ),
                                  description: const Text(
                                      "Si Completa Tu Perfil Puede Crear y Ofrecer Tu Servicios Ademas dejara de Ver este Moslesto Aviso"))


                      ) :

                      buildSingleChildScrollView(dataUser, avatar, themeprovider, screenSize, context),

                  Container(
                    child: InstagramPostCard(username: 'Jl;abox',
                        caption: 'Buy Lua', imageUrl: 'https://picsum.photos/200/300', colorbtn: themeprovider.currentTheme.primaryColor),
                  )

                ],
              )
              // SingleChildScrollView(
              //   // color: Colors.red,
              //   padding: Completdado == "NO" && tipo == 'F'
              //       ? const EdgeInsets.symmetric(vertical: 250, horizontal: 14)
              //       : EdgeInsets.zero,
              //   child: Completdado == "NO" && tipo == 'F'
              //       ? ElegantNotification.info(
              //           notificationPosition: NotificationPosition.center,
              //           // animation: AnimationType.fromTop,
              //           width: screenSize.width,
              //           height: 110,
              //           displayCloseButton: true,
              //           toastDuration: const Duration(seconds: 12),
              //           title: const Text(
              //             "Completar Perfil Para Ver Contenido",
              //             style: TextStyle(
              //                 fontWeight: FontWeight.bold, fontFamily: 'georgia'),
              //           ),
              //           description: const Text(
              //               "Si Completa Tu Perfil Puede Crear y Ofrecer Tu Servicios Ademas dejara de Ver este Moslesto Aviso"))
              //       : dataUser.allPelfiles.isNotEmpty //&& Completdado != "NO"
              //           ? facilitadores_card(
              //               dataUser, avatar, themeprovider, screenSize,context)
              //           : const SizedBox(
              //               height: 200,
              //               child: Center(child: CircularProgressIndicator())),
              // ),
              )),
    );
  }

  SingleChildScrollView buildSingleChildScrollView(FirebaseProvider dataUser, String avatar, ThemeSetting themeprovider, Size screenSize, BuildContext context) {
    return SingleChildScrollView(

                  scrollDirection: Axis.horizontal,
                 child:
                 Row(
                   crossAxisAlignment: CrossAxisAlignment.start,
                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                   children: dataUser.allPelfiles.reversed.map((e) {
                     if (e['avatar'].isNotEmpty) {
                       avatar = e['avatar'].last.toString();
                     }
                     return Container(
                       decoration: BoxDecoration(
                           gradient: LinearGradient(colors: [
                             themeprovider.currentTheme.primaryColor.withOpacity(0.4),
                             themeprovider.currentTheme.secondaryHeaderColor
                                 .withOpacity(0.6),
                           ]),
                           borderRadius: const BorderRadius.only(
                               bottomLeft: Radius.circular(15),
                               bottomRight: Radius.circular(5),
                               topLeft: Radius.circular(15),
                               topRight: Radius.circular(0)),
                           boxShadow: [
                             BoxShadow(
                                 color: themeprovider.currentTheme.primaryColor,
                                 blurRadius: 1,
                                 spreadRadius: 1.7,
                                 blurStyle: BlurStyle.outer,
                                 offset: Offset.fromDirection(8, 1)),
                           ]),
                       padding: const EdgeInsets.all(20),
                       margin: const EdgeInsets.all(6),
                       width: screenSize.width - 70,
                       height: 150,
                       child: Row(
                         children: [
                           Expanded(
                             child: Column(
                               crossAxisAlignment: CrossAxisAlignment.start,
                               children: [
                                 Text(e['servicio'].toUpperCase(),
                                     style: georgia700(
                                         themeprovider.currentTheme.primaryColor, 12)),
                                 const SizedBox(
                                   height: 4,
                                 ),
                                 Text(
                                   e['nombre'],
                                   style: const TextStyle(
                                     color: Colors.white,
                                     fontSize: 12,
                                   ),
                                 ),
                                 const SizedBox(
                                   height: 15,
                                 ),
                                 SizedBox(
                                   height: 30,
                                   child: Text(
                                     'sexo: ${e['sexo']} | edad: ${e['edad']} |ciudad: ${e['ciudad']}',
                                     style: georgia700(Colors.white, 9),
                                   ),
                                 ),
                                 SizedBox(
                                   width: screenSize.width,
                                   height: 30,
                                   child: Row(
                                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                     children: [
                                       CustomElevateButton(
                                           text: 'Mas',
                                           color: themeprovider.currentTheme.primaryColor,
                                           icon: const Icon(Icons.add),
                                           width: 90,
                                           height: 50,
                                           function: () async {
                                             Navigator.push(
                                               context,
                                               MaterialPageRoute(
                                                 builder: (context) => WachtProfileView(
                                                     userP: '${e["usuario"]}'),
                                               ),
                                             );
                                           }),
                                       CustomElevateButton(
                                           text: 'Whs',
                                           color: themeprovider.currentTheme.primaryColor,
                                           icon: const Icon(FontAwesomeIcons.whatsapp),
                                           width: 90,
                                           height: 50,
                                           function: () async {
                                             await sendWhatMessage('${e["contacto"]}');
                                           }),
                                     ],
                                   ),
                                 )
                               ],
                             ),
                           ),
                           const SizedBox(
                             width: 12,
                           ),
                           Stack(
                             alignment: Alignment.center,
                             children: [
                               Container(
                                 width: 95,
                                 height: 95,
                                 decoration: BoxDecoration(
                                   color: themeprovider.currentTheme.primaryColor
                                       .withOpacity(0.2),
                                   borderRadius: BorderRadius.circular(40),
                                 ),
                               ),
                               ClipRRect(
                                 borderRadius: BorderRadius.circular(50),
                                 child: FadeInImage.assetNetwork(
                                   placeholder: 'assets/images/user.png',
                                   image: avatar,
                                   width: 100,
                                   height: 100,
                                   fit: BoxFit.cover,
                                 ),
                               ),
                             ],
                           ),
                         ],
                       ),
                     );
                   }).toList(),
                 ),

                );
  }



  TextStyle georgia700(color, double size) {
    return TextStyle(
        fontFamily: 'georgia',
        fontWeight: FontWeight.w700,
        color: color,
        fontSize: size);
  }

  bool getCurrentTheme(Color color) {
    bool isOK = false;
    if (color == AppColors.aguilaColors) isOK = true;
    if (color == AppColors.yankeeblue) isOK = true;
    return isOK;
  }

  TextStyle georgianormal(color) {
    return TextStyle(
        fontFamily: 'georgia', fontWeight: FontWeight.normal, color: color);
  }
}
