import 'package:services_joined/provider/firebase/crud_fire_user.dart';

String get_userinformations(FirebaseProvider dataUser, String variable) {
  if (dataUser.listPelfil.isNotEmpty) {
    switch (variable) {
      case 'usuario':
        variable = dataUser.listPelfil.first['usuario'];
        break;

        case 'foto':
          if (dataUser.listPelfil.first['foto'].isNotEmpty) {
            variable = dataUser.listPelfil.first['foto'].last;
          } else {
            variable = '';
          }
        break;
      case 'pick':
        if (dataUser.listPelfil.first['foto'].isNotEmpty) {
          variable = dataUser.listPelfil.first['foto'].length.toString();
        } else {
          variable = 'pick';
        }
        break;
      case 'documento':
        variable = dataUser.listPelfil.first['document'];
        break;
      case 'uid':
        variable = dataUser.listPelfil.first['uid'].toString();
        break;

      case 'nombre':
        variable =  '${dataUser.listPelfil.first['nombre']+ " "+ dataUser.listPelfil.first['apellidos'] }';
        break;

      case 'perfil':
        variable = dataUser.isCompleted ? "OK":"NO";
        break;

      case 'tipo':
        variable = dataUser.listPelfil.first['tipo'].toString();
        break;
      default:
        variable = '';
        break;
    }
  }
  return variable;
}
