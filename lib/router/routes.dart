import 'package:fluro/fluro.dart';
import 'package:services_joined/router/handlerouter.dart';

class ServiceRouter {
  static final FluroRouter router = FluroRouter();

  static String login= 'login';
  static String register= 'register';
  static String ediperfil= 'editperfil';
  static String home= 'home';

  static void configureRoutes(){
    router.define(login, handler: HandleRoutes.loginhandler, transitionType: TransitionType.none);
    router.define(register, handler: HandleRoutes.registerhadler, transitionType: TransitionType.none);
    router.define(ediperfil, handler: HandleRoutes.perfilhadler, transitionType: TransitionType.none);
    router.define(home, handler: HandleRoutes.homehadler, transitionType: TransitionType.none);

  }
}