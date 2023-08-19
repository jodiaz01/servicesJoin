import 'package:flutter/material.dart';
import 'package:ServiPro/shared/shared_preferences.dart';
import 'package:ServiPro/src/utils/appcolor.dart';

class ThemeSetting extends ChangeNotifier {
  ThemeData _currentTheme = ThemeData.light();

  ThemeData get currentTheme => _currentTheme;
  bool _mode = false;
  bool _othermode = false;
  SharedPref pref = SharedPref();

  int totalTheme = 6;

  ///Todo Recuarda cada vez que agregue un tema incremetal el totaltheme

//lee lostema guardados
  ThemeSetting(int inttheme) {
    switch (inttheme) {
      case 1:
        _currentTheme = ThemeData.light();
        break;
      case 2:
        _currentTheme = ThemeData.dark();

        break;
      case 3:
        _currentTheme = CustomTheme.pinkTheme;
        break;
      case 4:
        _currentTheme = CustomTheme.yankkesTheme;
        break;
      case 5:
        _currentTheme = CustomTheme.aguilaTheme;
        break;
      case 6:
        _currentTheme = CustomTheme.superBlack;
        break;
      default:
        break;
    }
  }

  bool get othermode => _othermode;

  set othermode(bool value) {
    _othermode = value;
    notifyListeners();
  }

  int _numberTheme = 0;

  int get numberTheme => _numberTheme;

  set numberTheme(int value) {
    _numberTheme = value;
    notifyListeners();
  }

  bool get mode => _mode;

  set mode(bool value) {
    _mode = value;
    notifyListeners();
  }

//cambia los temas y lo guarda
  changeTheme() async {
    switch (numberTheme) {
      case 1:
        _currentTheme = ThemeData.light();
        pref.saveLocal('theme', numberTheme);
        break;
      case 2:
        _currentTheme = ThemeData.dark();
        pref.saveLocal('theme', numberTheme);

        break;
      case 3:
        _currentTheme = CustomTheme.pinkTheme;

        pref.saveLocal('theme', numberTheme);

        break;
      case 4:
        _currentTheme = CustomTheme.yankkesTheme;

        pref.saveLocal('theme', numberTheme);

        break;
      case 5:
        _currentTheme = CustomTheme.aguilaTheme;

        pref.saveLocal('theme', numberTheme);

        break;
      case 6:
        _currentTheme = CustomTheme.superBlack;

        pref.saveLocal('theme', numberTheme);

        break;
      default:
        break;
    }

    notifyListeners();
  }
}

class CustomTheme {
  static ThemeData get pinkTheme {
    //1
    return ThemeData(
      primaryColor: AppColors.primaryColor3,
      appBarTheme: const AppBarTheme(color: AppColors.primaryColor3),
      textTheme: const TextTheme(
        displayLarge: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        titleLarge: TextStyle(fontSize: 16, fontStyle: FontStyle.italic),
        bodyMedium: TextStyle(fontSize: 14, fontFamily: 'Hind'),
      ),
    );
  }

  static ThemeData get yankkesTheme {
    //1
    return ThemeData(
      primaryColor: AppColors.yankeeblue,
      appBarTheme: const AppBarTheme(color: AppColors.yankeeblue),
      textTheme: const TextTheme(
        displayLarge: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        titleLarge: TextStyle(fontSize: 16, fontStyle: FontStyle.italic),
        bodyMedium: TextStyle(fontSize: 14, fontFamily: 'Hind'),
      ),
    );
  }

  static ThemeData get aguilaTheme {
    //1
    return ThemeData(
      primaryColor: AppColors.aguilaColors,
      appBarTheme: const AppBarTheme(color: AppColors.aguilaColors),
      textTheme: const TextTheme(
        displayLarge: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        titleLarge: TextStyle(fontSize: 16, fontStyle: FontStyle.italic),
        bodyMedium: TextStyle(fontSize: 14, fontFamily: 'georgia'),
      ),
    );
  }

  static ThemeData get superBlack {
    return ThemeData(

        useMaterial3: true,
        primaryColor: AppAllColors.black,
        secondaryHeaderColor: AppColors.blackSuper,
        appBarTheme: const AppBarTheme(color: AppColors.blackColor),
        textTheme: const TextTheme(
          displayMedium: TextStyle(
              fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
          displaySmall: TextStyle(
              fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
          displayLarge: TextStyle(
              fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
        ),
    );
  }
}
