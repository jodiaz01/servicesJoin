import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:ServiPro/provider/theme/theme.dart';
import 'package:ServiPro/router/routes.dart';
import 'package:ServiPro/shared/shared_preferences.dart';
import 'package:ServiPro/src/utils/navigateservice.dart';
import 'package:ServiPro/src/view/posted/post_view.dart';
import 'package:ServiPro/src/view/testview.dart';

import 'package:ServiPro/src/view/theme/themechange_view.dart';

class CustomNavigationBar extends StatefulWidget {
  CustomNavigationBar(this.page, this.bottomNavigationKey, this.color, this.colorback, this.avatar);
  Color color;
  Color colorback;
  String ? avatar;

  int page = 0;

  GlobalKey<CurvedNavigationBarState> bottomNavigationKey = GlobalKey();

  @override
  State<CustomNavigationBar> createState() => _CustonNavigationBarState();
}

class _CustonNavigationBarState extends State<CustomNavigationBar> {
  int index = 0;

  @override
  void setState(VoidCallback fn) {
    index = widget.page;
    super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    final providel = Provider.of<ThemeSetting>(context);

    // currenpage(widget.page);

    return CurvedNavigationBar(
      key: widget.bottomNavigationKey,
      index: 2,
      height: 60.0,
      items:  <Widget>[
        const Icon(Icons.power_settings_new_outlined,size: 30,color: Colors.white),
        const Icon(Icons.post_add_rounded, size: 30, color: Colors.white),
        widget.avatar!.contains('https')  && widget.avatar != null ?
        ClipOval(child: Image.network(widget.avatar.toString(), width:40,height: 40,fit: BoxFit.contain
          ,)):
        Image.asset('assets/images/user.png', width:40,height: 40,fit: BoxFit.fill,),
        // Icon(Icons.search, size: 30, color: Colors.white),
        const Icon(Icons.perm_identity, size: 30, color: Colors.white),
        const Icon(Icons.settings, size: 30, color: Colors.white),
      ],
      color:widget.color,
      buttonBackgroundColor: providel.currentTheme.primaryColor,
      backgroundColor: widget.colorback,
      animationCurve: Curves.easeInOut,
      animationDuration: const Duration(milliseconds: 600),
      onTap: (index) {
        setState(() {
          widget.page = index;
        });

        page_navigate(index, context);
      },
      letIndexChange: (index) => true,
    );
  }

  Future<void> page_navigate(int index, BuildContext context) async {
    switch(index){
      case 0:
        await SharedPref().remove('user');
         await NavigationService.replaceTo(ServiceRouter.login);

        //  SystemNavigator.pop();
    break;
      case 1:

        await Navigator.push(context, MaterialPageRoute(builder: (_) => const PostView()));
        // await Navigator.push(context, MaterialPageRoute(builder: (_) => const TestView()));

        break;
      case 2:
        // await Navigator.push(context, MaterialPageRoute(builder: (_) => TestView()));
        break;
      case 3:
        await NavigationService.pasaTo(ServiceRouter.ediperfil);
        break;
      case 4:
        await Navigator.push(context, MaterialPageRoute(builder: (_) => const MyThemeView()));
        break;
    }
  }

  //
  void currenpageSelected(page) {
    final CurvedNavigationBarState? navBarState =
        widget.bottomNavigationKey.currentState;
    navBarState?.setPage(page);
  }
}
