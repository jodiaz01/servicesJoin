import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:ServiPro/provider/theme/theme.dart';
import 'package:ServiPro/src/utils/appcolor.dart';
import 'package:ServiPro/src/widget/customappbar.dart';

class MyThemeView extends StatelessWidget {
  const MyThemeView({super.key});

  @override
  Widget build(BuildContext context) {
    final themeprovider = Provider.of<ThemeSetting>(context);

    return Scaffold(
      backgroundColor: themeprovider.currentTheme.primaryColor,
      body: CustomAppbar(
        elevation: 0.4,
        title: Text("Tema de tu Preferencia"),
        icon: Icon(
          Icons.light_mode_outlined,
          size: 38,
          color: themeprovider.currentTheme.secondaryHeaderColor,
        ),
        child: Padding(
            padding: const EdgeInsets.all(20),
            child: ListView.separated(
                physics: const BouncingScrollPhysics(),
                itemCount: themeprovider.totalTheme,
                separatorBuilder: (BuildContext context, int index) =>
                    const Divider(),
                itemBuilder: (BuildContext context, int index) {
                  print('totla inedex $index');
                  return ListTile(
                      onTap: () {
                        changeTheme(themeprovider, true, index + 1);
                      },
                      title: index == 0
                          ? const Text(
                              'Modo Claro',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.primaryColor1),
                            )
                          : index == 1
                              ? Text('Modo oscuro',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,color: Colors.grey.shade700
                                  ))
                              : index == 2
                                  ? const Text('Cripsom claro',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: AppColors.primaryColor3))
                                  : index == 3 ? const Text('Modo Yankees',style: TextStyle(fontWeight: FontWeight.bold,color: AppColors.yankeeblue))
                                      : index == 4 ? const Text('Modo Aguila',style: TextStyle(fontWeight: FontWeight.bold,color:AppColors.aguilaColors))
                                      : index == 5 ?  Text('Super Negro',style: TextStyle(fontWeight: FontWeight.bold,color:Colors.grey.shade800))
                                          : SizedBox(),
                      leading: index == 0
                          ? const Icon(FontAwesomeIcons.lightbulb,
                              color: AppColors.primaryColor1)
                          : index == 1
                              ? const Icon(Icons.light_mode_outlined)
                              : index == 2
                                  ? const Icon(
                                      Icons.sunny_snowing,
                                      color: AppColors.primaryColor3,
                                    )
                                  : index == 3
                                      ? const Icon(Icons.cloud_queue,
                                          color: AppColors.yankeeblue)
                                      : index == 4? const Icon(FontAwesomeIcons.crow,color: AppColors.aguilaColors)
                                      : index == 5 ?  Icon(FontAwesomeIcons.hollyBerry,color:Colors.grey.shade800)
                                          : SizedBox());
                })),
      ),
    );
  }

  void changeTheme(ThemeSetting themeprovider, bool value, int ntheme) {
    switch (ntheme) {
      case 1:
        themeprovider.mode = value;
        themeprovider.numberTheme = ntheme;
        break;
      case 2:
        themeprovider.mode = value;
        themeprovider.numberTheme = ntheme;
        break;
      case 3:
        themeprovider.othermode = value;
        themeprovider.numberTheme = ntheme;
        break;
      case 4:
        themeprovider.othermode = value;
        themeprovider.numberTheme = ntheme;
        break;
      case 5:
        themeprovider.othermode = value;
        themeprovider.numberTheme = ntheme;
        break;
      case 6:
        themeprovider.othermode = value;
        themeprovider.numberTheme = ntheme;
        break;
      default:
    }

    themeprovider.changeTheme();
  }
}
// Padding(
//   padding: const EdgeInsets.all(10),
//   child: Switch.adaptive(
//     value: themeprovider.mode,
//     onChanged: (value) {
//       value
//           ? changeTheme(themeprovider, value, 1)
//           : changeTheme(themeprovider, value, 2);
//     },
//     activeColor: Colors.blue,
//   ),
// ),
// Padding(
//   padding: const EdgeInsets.all(12.0),
//   child: Switch.adaptive(
//     value: themeprovider.othermode,
//     onChanged: (value) {
//       value
//           ? changeTheme(themeprovider, value, 3)
//           : changeTheme(themeprovider, value, 4);
//     },
//     activeColor: Colors.blue,
//   ),
// ),
// const Text('Hello World'),
//todo  hace la funcion de las paginas cuando se presiona un botom
// ElevatedButton(
//   child: Text('Go To Page of index 1'),
//   onPressed: () {
//     final CurvedNavigationBarState? navBarState =
//         _bottomNavigationKey.currentState;
//     navBarState?.setPage(2);
//   },
// )
