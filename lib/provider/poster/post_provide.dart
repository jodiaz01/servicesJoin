import 'package:flutter/material.dart';
import 'package:services_joined/models/user_post.dart';

class PostFormProvider extends ChangeNotifier {
  GlobalKey<FormState> formkey = GlobalKey<FormState>();

  bool _creado = false;

  bool get creado => _creado;

  set creado(bool value) {
    _creado = value;
    notifyListeners();
  }

  UserPost userPost = UserPost(
      id: 0,
      uid: 0,
      cliente: [],
      titulo: '',
      descripcion: '',
      costo: 0,
      fecha: DateTime.now(),
      img: [],
    video: [],
    audience:null
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