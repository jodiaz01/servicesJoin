import 'package:flutter/material.dart';
import 'package:ServiPro/models/user_model.dart';

class RegisterFormProvider extends ChangeNotifier {
  GlobalKey<FormState> formkey = new GlobalKey<FormState>();

  bool _creado =false;

  bool get creado => _creado;

  set creado(bool value) {
    _creado = value;
    notifyListeners();
  }

  Usuario usuarios = Usuario(
      uid: 0,
      tipo: '',
      firstName: '',
      lastName: '',
      username: '',
      password: '',
      biometric: false,
      email:'',
      isActive: true,
      lastLogin: DateTime.now(),
      dateJoined: DateTime.now(),
      foto: []
  );

  bool validateForm() {
    if (formkey.currentState!.validate()) {
      // print('$email --- $password');
      return true;
    } else {
      // print('no valido');
      return false;
    }
  }
}
