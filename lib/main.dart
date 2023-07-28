import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:services_joined/firebase_options.dart';
import 'package:services_joined/provider/firebase/crud_fire_post.dart';
import 'package:services_joined/provider/theme/theme.dart';
import 'package:services_joined/provider/user/detail_profile_provider.dart';
import 'package:services_joined/provider/user/register_provider.dart';
import 'package:services_joined/router/routes.dart';
import 'package:services_joined/shared/shared_preferences.dart';
import 'package:services_joined/src/utils/navigateservice.dart';
import 'package:services_joined/src/view/home/home_page_view.dart';
import 'package:services_joined/src/view/login/login_view.dart';
import 'package:services_joined/src/view/login/register_view.dart';
import 'package:services_joined/src/view/profile/perfil_view.dart';
import 'package:services_joined/src/view/profile/watch_profiles_view.dart';

import 'provider/firebase/crud_fire_user.dart';

// enum  Authenticate { isLogin,noLogin, isParnet, noParnet}
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  SharedPref pref = SharedPref();
  final inttheme = await pref.read('theme') ?? 1;
  final user = await pref.read('user') ?? false;
  bool seccionExists = user != false ? true : false;
    // print('USUARIO DISPONIBLE EN EL ARTICULOS 10 ${user["usuario"]}');

  runApp(ServiceJoined(
    inttheme: inttheme,
    isLogin: seccionExists,
  ));
}

class ServiceJoined extends StatelessWidget {
  const ServiceJoined(
      {super.key, required this.inttheme, required this.isLogin});

  final int inttheme;
  final bool isLogin;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: [
      ChangeNotifierProvider(lazy: true, create: (_) => RegisterFormProvider()),
      ChangeNotifierProvider(lazy: true, create: (_) => DetailsFormProvider()),
      ChangeNotifierProvider( create: (_) => FirebaseProvider()),
      ChangeNotifierProvider( create: (_) => FirebasePost()),
      // ChangeNotifierProvider( create: (_) => SliderModelProvider()),


      ChangeNotifierProvider(
          create: (context) => ThemeSetting(inttheme),
          builder: (context, snashot) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              initialRoute: !isLogin ? 'login' : 'home',
              onGenerateRoute: ServiceRouter.router.generator,
              navigatorKey: NavigationService.navigatorKey,
              routes: {
                ServiceRouter.login: (_) => const LoginView(),
                ServiceRouter.register: (_) => const RegisterView(),
                ServiceRouter.ediperfil: (_) =>  PerfilView(),
                ServiceRouter.home: (_) => const HomePageView(),
              },
            );
          }),

      // ChangeNotifierProvider(lazy: true, create: (_) => RegisterProvider()),
    ]);
  }
}
