import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:ServiPro/provider/firebase/crud_fire_user.dart';
import 'package:ServiPro/provider/theme/theme.dart';
import 'package:ServiPro/shared/whatsapp_msg.dart';
import 'package:ServiPro/src/utils/appcolor.dart';
import 'package:ServiPro/src/widget/custom_subtitle.dart';
import 'package:ServiPro/src/widget/customappbar.dart';
import 'package:ServiPro/src/widget/custon_elevateButton.dart';
import 'package:ServiPro/src/widget/slide_widget/format_slide_widget.dart';
import 'package:url_launcher/url_launcher.dart';

class WachtProfileView extends StatelessWidget {
  const WachtProfileView({super.key, this.userP});

  final String? userP;

  @override
  Widget build(BuildContext context) {
    final themeprovider = Provider.of<ThemeSetting>(context);
    final userProvider = Provider.of<FirebaseProvider>(context);

    List listaFiltrada = [];
    List lImages = [];
    if (userProvider.allPelfiles.isNotEmpty) {
      listaFiltrada = userProvider.allPelfiles.where((mapa) {
        return (mapa['usuario']) == userP;
      }).toList();

      if (listaFiltrada.isNotEmpty) {
        lImages = listaFiltrada.first['avatar'].map((r) => r).toList();
      }
    }

    return Scaffold(
      backgroundColor: themeprovider.currentTheme.primaryColor,
      body: CustomAppbar(
          elevation: 0.30,
          icon: Stack(
            children: [
              const Positioned(
                bottom: 0,
                left: 38,
                child: SizedBox(),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 12.0),
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(120),
                    child: listaFiltrada.isEmpty && lImages.isEmpty ||
                            (listaFiltrada.last['avatar'] == '')
                        ? const FadeInImage(
                            fadeInDuration: Duration(seconds: 4),
                            placeholder:
                                AssetImage('assets/images/user.png'),
                            image: AssetImage('assets/images/user.png'),
                            width: 100,
                            height: 100,
                          )
                        : Image.network(
                            listaFiltrada.first['avatar'].last,
                            width: 220,
                            height: 220,
                            fit: BoxFit.cover,
                          )),
              ),
            ],
          ),
          child: listaFiltrada.isNotEmpty && lImages.isNotEmpty
              ? SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width,
                        padding: const EdgeInsets.symmetric(
                            vertical: 20, horizontal: 15),
                        decoration: customDecorator(
                          themeprovider,
                          0,
                          0,
                          20,
                          20,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                             listaFiltrada.first['tipo'] == 'F' ? listaFiltrada.first['servicio'].toString().toUpperCase() : '@${listaFiltrada.first['usuario'].toString().toUpperCase()}',
                              style: const TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            Wrap(
                              runAlignment: WrapAlignment.spaceBetween,
                              crossAxisAlignment: WrapCrossAlignment.center,
                              children: [
                                Text(
                                  listaFiltrada.first['nombre'].toString().toUpperCase(),
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                             const   SizedBox(width: 14,),
                                CustomElevateButton(
                                    function: () async{
                                  await    sendWhatMessage(listaFiltrada.first['contacto'].toString().trim());
                                    },
                                    color: themeprovider
                                        .currentTheme.primaryColor
                                        .withOpacity(0.2),
                                    text: listaFiltrada.first['contacto']
                                        .toString(),
                                    width: 150,
                                    height: 20,
                                    icon: const Icon(FontAwesomeIcons.whatsapp)),
                              ],
                            ),

                            // Text(
                            //   "EMAIL: ${listaFiltrada.first['email'].toString()}",
                            //   style: const TextStyle(
                            //     fontSize: 12,
                            //     fontWeight: FontWeight.w400,fontFamily: 'georgia'
                            //
                            //   ),
                            // ),
                            const SizedBox(
                              height: 8,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 12),
                      Padding(
                        padding:
                            const EdgeInsets.only(left: 8, right: 8, top: 4),
                        child: Row(
                          children: [
                            Expanded(
                              child: TitleSubtitleCell(
                                color: themeprovider.currentTheme.primaryColor,
                                title: listaFiltrada.first['edad'].toString(),
                                subtitle: "Anos",
                              ),
                            ),
                            const SizedBox(
                              width: 15,
                            ),
                            Expanded(
                              child: TitleSubtitleCell(
                                color: themeprovider.currentTheme.primaryColor,
                                title: listaFiltrada.first['sexo'] == 'F'
                                    ? 'Femenino'
                                    : 'Masculino',
                                subtitle: 'Genero',
                              ),
                            ),
                            const SizedBox(
                              width: 15,
                            ),
                            listaFiltrada.first['tipo'] == 'F'?
                            Expanded(
                              child: TitleSubtitleCell(
                                color: themeprovider.currentTheme.primaryColor,
                                title:
                                    "${listaFiltrada.first['esperiencia']}|${listaFiltrada.first['tiempo']} ",
                                subtitle: "Esperiencias",
                              ),
                            ) : SizedBox(),
                          ],
                        ),
                      ),
                      Divider(
                          color: themeprovider.currentTheme.primaryColor,
                          height: 12),
                      Card(
                        color: themeprovider.currentTheme.secondaryHeaderColor,
                        margin: const EdgeInsets.all(8),
                        child: Column(
                          children: [
                            ListTile(
                              title: Text(
                                "Mas Sobre ${listaFiltrada.first['nombre']}",
                                style: const TextStyle(
                                  color: AppColors.blackColor,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                            const Divider(
                              height: 8,
                            ),
                            listaFiltrada.first['tipo'] == 'F'?

                            ListTile(
                              leading: Icon(Icons.abc_outlined,
                                  size: 36,
                                  color:
                                      themeprovider.currentTheme.primaryColor),
                              title: const Text(
                                'Sobre Mi Servicios',
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    decoration: TextDecoration.underline),
                              ),
                              subtitle: Text(
                                listaFiltrada.first['detalle_servicio'],
                                style: const TextStyle(color: Colors.black54),
                              ),
                            ): SizedBox(),
                            ListTile(
                              leading: Icon(Icons.mail_outline,
                                  size: 36,
                                  color:
                                  themeprovider.currentTheme.primaryColor),
                              title: const Text(
                                'Email',
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    decoration: TextDecoration.underline),
                              ),
                              subtitle: Text(
                                listaFiltrada.first['email'],
                                style: const TextStyle(color: Colors.black54),
                              ),
                            ),

                            ListTile(
                              leading: Icon(FontAwesomeIcons.facebook,
                                  size: 36,
                                  color:
                                      themeprovider.currentTheme.primaryColor),
                              title: const Text(
                                'Redes Sociales',
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    decoration: TextDecoration.underline),
                              ),
                              subtitle: Text(
                                listaFiltrada.first['rede_social'],
                                style: const TextStyle(color: Colors.black54),
                              ),
                            ),
                            ListTile(
                              leading: Icon(
                                FontAwesomeIcons.map,
                                size: 36,
                                color: themeprovider.currentTheme.primaryColor,
                              ),
                              title: const Text(
                                'Otro Datos',
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    decoration: TextDecoration.underline),
                              ),
                              subtitle: Text(
                                "Ciudad: ${listaFiltrada.first['ciudad'].toString().toUpperCase()}\n"
                                "Sector: ${listaFiltrada.first['sector_barrio'].toString().toUpperCase()}\n"
                                "Direccion: ${listaFiltrada.first['direcion_ubicacion'].toString().toUpperCase()} ",
                                style: const TextStyle(color: Colors.black54),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 6),
                      Container(
                          margin: const EdgeInsets.all(8),
                          padding: const EdgeInsets.all(4),
                          // decoration: customDecorator(themeprovider, 4, 4, 4, 4,false),
                          // width: MediaQuery.of(context).size.width -20,
                          height: MediaQuery.of(context).size.height * 0.4,
                          child: Card(
                            color:
                                themeprovider.currentTheme.secondaryHeaderColor,
                            child: Stack(
                              children: [
                                PasaSlider(
                                    sizepuntoPrimario: 12,
                                    sizepuntoSecundar: 10,
                                    toppage: false,
                                    //  : false, //si se muestran arriba
                                    colorPrimario:
                                        themeprovider.currentTheme.primaryColor,
                                    //cambithendicadores
                                    colorSecundario: Colors.black26,
                                    // cambia el bacolor de los indicadores
                                    lislider: lImages
                                        .map(
                                          (e) => ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            child: e == ''
                                                ? const FadeInImage(
                                                    fadeInDuration:
                                                        Duration(seconds: 4),
                                                    placeholder: AssetImage(
                                                        'assets/images/user.png'),
                                                    image: AssetImage(
                                                        'assets/images/user.png'),
                                                    width: 100,
                                                    height: 100,
                                                  )
                                                : Image.network(
                                                    e,
                                                    fit: BoxFit.contain,
                                                  ),
                                          ),
                                        )
                                        .toList()),
                                Positioned(
                                  left: -2,
                                  top: -1,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(30),
                                    child: lImages.reversed.first == ''
                                        ? const FadeInImage(
                                            fadeInDuration:
                                                Duration(seconds: 8),
                                            placeholder: AssetImage(
                                                'assets/images/user.png'),
                                            image: AssetImage(
                                                'assets/images/user.png'),
                                            width: 50,
                                            height: 50,
                                          )
                                        : ClipOval(
                                            child: Image.network(
                                              lImages.reversed.first,
                                              fit: BoxFit.fill,
                                              height: 80,
                                              width: 80,
                                            ),
                                          ),
                                  ),
                                ),
                              ],
                            ),
                          )),
                      const SizedBox(height: 12),
                    ],
                  ),
                )
              : const Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: 60),
                      CircularProgressIndicator(),
                      SizedBox(height:20),

                      Expanded(child: Text('.. Cargando  Espere ..!')),
                    ],
                  ),
                )),
    );
  }

  BoxDecoration customDecorator(
      themeprovider, double bLeft, double bRight, double tLeft, double tRigt) {
    return BoxDecoration(
      gradient: LinearGradient(colors: [
        Colors.white,
        themeprovider.currentTheme.primaryColor.withOpacity(0.5),
        themeprovider.currentTheme.primaryColor,
      ]),
      boxShadow: [
        BoxShadow(
            color: themeprovider.currentTheme.primaryColor,
            blurStyle: BlurStyle.outer,
            spreadRadius: 2,
            blurRadius: 2)
      ],
      color: Colors.white70,
      borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(bLeft),
          bottomRight: Radius.circular(bRight),
          topLeft: Radius.circular(tLeft),
          topRight: Radius.circular(tRigt)),
    );
  }
}
