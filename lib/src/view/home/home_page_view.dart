import 'package:ServiPro/provider/firebase/crud_fire_post.dart';
import 'package:ServiPro/src/widget/profiles/profile_card.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:elegant_notification/elegant_notification.dart';
import 'package:elegant_notification/resources/arrays.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:ServiPro/provider/firebase/crud_fire_user.dart';
import 'package:ServiPro/provider/theme/theme.dart';
import 'package:ServiPro/src/utils/appcolor.dart';
import 'package:ServiPro/src/utils/datauser_comun.dart';
import 'package:ServiPro/src/view/profile/watch_profiles_view.dart';
import 'package:ServiPro/src/widget/aguila_container.dart';
import 'package:ServiPro/src/widget/animate_bottonav.dart';
import 'package:ServiPro/src/widget/customappbar.dart';
import 'package:ServiPro/src/widget/postcard/custom_post.dart';
import 'package:ServiPro/src/widget/team_creator.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';


class HomePageView extends StatelessWidget {
  const HomePageView({super.key});

  @override
  Widget build(BuildContext context) {
    GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();
    final themeprovider = Provider.of<ThemeSetting>(context);
    final cureenrthemcolor = themeprovider.currentTheme.primaryColor;
    final firebasePost = Provider.of<FirebasePost>(context);
    String tipo = '';
    String foto = '';
    String Completdado = '';

    Color color = themeprovider.currentTheme.primaryColor;
    Color colorbac = Colors.amber;
    Color cblack = Colors.black;

    if (cureenrthemcolor == AppColors.aguilaColors) {
      colorbac = Colors.amber;
    }
    final screenSize = MediaQuery.of(context).size;
    FirebaseProvider dataUser = Provider.of<FirebaseProvider>(context);

    String user = get_userinformations(dataUser, 'usuario');
    tipo = get_userinformations(dataUser, 'tipo');
    foto = get_userinformations(dataUser, 'foto');
    Completdado = get_userinformations(dataUser, 'perfil');

    // getPostById(firebasePost);
    String avatar = '';
    return Scaffold(
      bottomNavigationBar:
          CustomNavigationBar(0, _bottomNavigationKey, color, colorbac, foto),
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
                              'NY',
                              themeprovider.currentTheme.secondaryHeaderColor
                                  .withOpacity(0.6)),
                        ),
                      ),
                      const Positioned(
                          top: 15,
                          //right: 12,
                          left: 38,
                          child: SizedBox(
                            height: 120,
                          )),
                    ],
                  )
                : Padding(
                    padding: const EdgeInsets.all(18),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Hi..! $user',
                          style:  GoogleFonts.pacifico(
                              color: Colors.white,
                              fontSize: 18,
                          //    fontFamily: 'Georgia'
                          ),

                        ), GradientText(
                          colors:themeprovider.currentTheme.primaryColor != cblack && themeprovider.currentTheme.primaryColor != Colors.black ? [Colors.white,themeprovider.currentTheme.secondaryHeaderColor]:  AppColors.Raimbox,
                          'Services Pro',
                          style:  GoogleFonts.pacifico(
                            fontSize: 22,
                            //    fontFamily: 'Georgia'
                          ),

                        ),
                      ],
                    ),
                  ),

        child: RefreshIndicator(
          color: Colors.white70,
          backgroundColor: themeprovider.currentTheme.primaryColor,
          onRefresh: () async {
            await dataUser.iniciaData();
            await firebasePost.readPoster();
          },
          child: ListView(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.only(top: 0, bottom: 8),
            children: [
              Completdado == "NO" && tipo == 'F'
                  ? Padding(
                      padding: const EdgeInsets.all(20),
                      child: ElegantNotification.info(
                          notificationPosition: NotificationPosition.center,
                          // animation: AnimationType.fromTop,
                          width: screenSize.width,
                          height: 110,
                          displayCloseButton: true,
                          toastDuration: const Duration(seconds: 12),
                          title: const Text(
                            "Completar Perfil Para Ver Contenido",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontFamily: 'georgia'),
                          ),
                          description: const Text(
                              "Si Completa Tu Perfil Puede Crear y Ofrecer Tu Servicios Ademas dejara de Ver este Moslesto Aviso")))
                  : buildSingleChildScrollView(
                      dataUser, avatar, themeprovider, screenSize, context),
              firebasePost.dataPost.isNotEmpty
                  ? buildColumnPost(firebasePost, themeprovider, context, user,dataUser.listPelfil.isNotEmpty ? dataUser.listPelfil.first['uid']: 0)
                  : const SizedBox(),
            ],
          ),
        ),
      ),
    );
  }


  Column buildColumnPost(FirebasePost firebasePost, ThemeSetting themeprovider,
      BuildContext context, String user, int uId) {

    List<int> followingIds = firebasePost.Lsfollow
        .where((follower) {
          return follower['seguidorId'] ==uId;
        })
        .map<int>((follower) => follower['seguidoId'])
        .toList();
      // print(followingIds);
    return Column(
      children: firebasePost.dataPost.reversed.map((post) {
        bool isPublic = post['estado'] == 'public';
        bool isForFollowers = post['estado'] == 'client';

        if (isPublic) {
          return buildInstagramPostCard(post, themeprovider, context, user, false, uId);
        }  else if(( followingIds.contains(post['uid'])&& isForFollowers ) || post['uid']== uId) {
          return buildInstagramPostCard(post, themeprovider, context, user, false, uId);

        }

        else{
          return const SizedBox();
        }
      }).toList(),
    );
  }

  InstagramPostCard buildInstagramPostCard(e, ThemeSetting themeprovider,
      BuildContext context, String user, bool isOneFollowers, userId) {

    return InstagramPostCard(
      name: e['nombre'],
      // name: e['nombre']+e['uid'].toString()+ e['estado'],
      title: e['titulo'],
      caption: e['descripcion'],
      imageUrl: e['img'].isNotEmpty ? e['img'] : ['https://fakeimg.pl/600x400'],
      colorbtn: themeprovider.currentTheme.primaryColor ,
      avatar: e['avatar'].isNotEmpty
          ? e['avatar'].last
          : 'https://fakeimg.pl/600x400',
      precio: double.parse(e['costo'].toString()),
      onTap: () async {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => WachtProfileView(
              userP: '${e["usuario"]}',
            ),
          ),
        );
      },
      clienst: user,
      idocuments: e['documents'],
      follow: e['usuario'],
      idList: [e['uid'].toString(), userId.toString()],

      isFollower: isOneFollowers,
      // estado: e['estado'],
      // isFollower: e['usuario'] == user ? true :false ,
    );
  }

  SingleChildScrollView buildSingleChildScrollView(
      FirebaseProvider dataUser,
      String avatar,
      ThemeSetting themeprovider,
      Size screenSize,
      BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: dataUser.allPelfiles.reversed.map((e) {
          if (e['avatar'].isNotEmpty) {
            avatar = e['avatar'].last.toString();
          }
          return ProfilesCard(
              themeprovider: themeprovider, avatar: avatar, e: e);
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
