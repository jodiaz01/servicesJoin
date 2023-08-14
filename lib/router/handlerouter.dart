import 'package:fluro/fluro.dart';
import 'package:ServiPro/src/view/home/home_page_view.dart';
import 'package:ServiPro/src/view/login/login_view.dart';
import 'package:ServiPro/src/view/login/register_view.dart';
import 'package:ServiPro/src/view/profile/perfil_view.dart';
import 'package:ServiPro/src/view/profile/watch_profiles_view.dart';

class HandleRoutes{
  static Handler loginhandler = Handler(handlerFunc: (context, params) {
    return LoginView();
  });


  static Handler registerhadler = Handler(handlerFunc: (context, params) {
    return RegisterView();
  });
  static Handler perfilhadler = Handler(handlerFunc: (context, params) {
    return PerfilView();
  });

  static Handler homehadler = Handler(handlerFunc: (context, params) {
    return HomePageView();
  });

}

