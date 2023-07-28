import 'package:flutter/cupertino.dart';
import 'package:services_joined/models/user_datails.dart';

class DetailsFormProvider extends ChangeNotifier {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  bool _creado = false;

  bool get creado => _creado;

  set creado(bool value) {
    _creado = value;
    notifyListeners();
  }

  UserDatails userDatails = UserDatails(
      id: 0,
      uid: 0,
      servicio: '',
      detalle_servicio: '',
      esperiencia: 0,
      tiempo: '',
      contacto: '',
      otro_contacto: '',
      rede_social: '',
      ciudad: '',
      sector_barrio: '',
      direcion_ubicacion: '',
      sexo: '',
      edad: 0,
      // foto: []

  );

  bool validateForm() {
    if (formKey.currentState!.validate()) {
      // print('$email --- $password');
      return true;
    } else {
      // print('no valido');
      return false;
    }
  }
}
