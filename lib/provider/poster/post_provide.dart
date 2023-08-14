import 'package:flutter/material.dart';
import 'package:ServiPro/models/user_post.dart';
enum cap{ client,
  public,
  private,}
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
    audience:PostAudience.public,

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