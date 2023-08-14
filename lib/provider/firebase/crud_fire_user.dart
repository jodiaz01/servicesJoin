import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elegant_notification/elegant_notification.dart';
import 'package:elegant_notification/resources/arrays.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';
import 'package:ServiPro/conexion/server.dart';
import 'package:ServiPro/models/user_datails.dart';
import 'package:ServiPro/models/user_model.dart';
import 'package:ServiPro/provider/user/login_user.dart';
import 'package:ServiPro/router/routes.dart';
import 'package:ServiPro/shared/shared_preferences.dart';
import 'package:ServiPro/src/utils/navigateservice.dart';

class FirebaseProvider extends ChangeNotifier {
  final SharedPref _pref = SharedPref();
  List listPelfil = [];
  List allPelfiles = [];
  bool isCompleted = false;
  final LocalAuthentication _localAuthentication = LocalAuthentication();
  
  FirebaseProvider() {
    iniciaData();
  }

  Future<void> IniSeccion(LoginFormProvider provider, context,
      Color color, bool biometric) async {
    try {
      await _pref.remove("user");

      var data ;
      if(biometric){
        data = await Conexion.db
            .collection("users")
            .where("biometric", isEqualTo: true)
            .where("is_active", isEqualTo: true)
            .get();
      }
      else {
             data = await Conexion.db
            .collection("users")
            .where("username", isEqualTo: provider.email)
            .where("password", isEqualTo: provider.password)
            .where("is_active", isEqualTo: true)
            .get();

      }
      /// saber si hubo cambio en un docuemnto o tabla
      // final documents = await Conexion.db.collection('users').doc(data.docs.first.id);
      // documents.snapshots().listen((event) {
      //
      //   return  print('object econtrado es ${event.data()}');
      // });

      if (data.docs.isNotEmpty) {
        data.docs.map((e) async {
          // print(e.data());
          if (e.data()["username"] != "" && e.data()["password"] != "") {
            await sharedata(e.id);

            NavigationService.replaceTo(ServiceRouter.home);
          }
        }).toString();
      } else {
        ElegantNotification.error(
            animation: AnimationType.fromTop,
            notificationPosition: NotificationPosition.center,
            toastDuration: Duration(seconds: 4),
            title: Text("Error"),
            description: Text("Verifique usuario Y contrasena"))
            .show(context);

       
      }
      notifyListeners();
    } catch (error) {
      print('Hay un problemas Error: => $error');
    }
  }

  iniciaData() async {
    int userId = 0;
    final data = await _pref.read('user'); //datos preferencia usuario
    listPelfil.add(data);

    try {
      allPelfiles.clear();

      final usuariomap = await Conexion.db.collection('users').where('is_active', isEqualTo: true).get();
      //
      // final dataset = await Conexion.db.collection('perfil').withConverter(
      //     fromFirestore: UserDatails.fromFirestore,
      //     toFirestore: (UserDatails post, _) => post.toFirestore());

      for (var docSnapshot in usuariomap.docs) {
        final collet = await Conexion.db
            .collection('perfil')
            .where('uid', isEqualTo: docSnapshot.data()['uid'])
            .get();

        collet.docs.map((e) async {

          final map  = {
            "nombre": "${docSnapshot.data()['first_name']}, ${docSnapshot
                .data()['last_name']}",
            "usuario": docSnapshot.data()['username'],
            "avatar": docSnapshot.data()['foto'],
            'email': docSnapshot.data()['email'],
            'servicio': e.data()['servicio'],
            'detalle_servicio': e.data()['detalle_servicio'],
            'esperiencia': e.data()['esperiencia'],
            'tiempo': e.data()['tiempo'],
            'contacto': e.data()['contacto'],
            'otro_contacto': e.data()['otro_contacto'],
            'rede_social': e.data()['rede_social'],
            'ciudad': e.data()['ciudad'],
            'sector_barrio': e.data()['sector_barrio'],
            'direcion_ubicacion': e.data()['direcion_ubicacion'],
            'sexo': e.data()['sexo'],
            'edad': e.data()['edad'],
            'tipo': docSnapshot.data()['tipo'],
          };

          allPelfiles.add(map);
        }).toList();
      }


      /*// }
      // final dataset = await Conexion.db.collection('perfil').withConverter(
      //     fromFirestore: UserDatails.fromFirestore,
      //     toFirestore: (UserDatails post, _) => post.toFirestore());
      // final documeto = await dataset.get();
      // final userDatails = documeto.docs;
      // if (userDatails.isNotEmpty) {
      //   await userDatails.map((e) =>
      //       allPelfiles.add(e.data())).toList();
      // }*/
    } catch (e) {
      print(e);
    }
    if (listPelfil.first != null) {
      userId = int.parse(listPelfil.first['uid'].toString());
    }
    isCompleted = await perfilCompleto(userId);

    notifyListeners();
    return allPelfiles;
  }

  Future<bool> perfilCompleto(int uid) async {
    final data = await Conexion.db
        .collection('perfil')
        .where('uid', isEqualTo: uid)
        .get();

    if (data.docs.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  }

  Future<List<dynamic>> sharedata(documento_user) async {
    await SharedPref().remove('user');
    final docRef =
    await Conexion.db.collection('users').doc(documento_user).get();
    final pref = {
      "document": docRef.id,
      "tipo": docRef['tipo'],
      "uid": docRef['uid'],
      "usuario": docRef["username"],
      "nombre": docRef["first_name"],
      "apellidos": docRef["last_name"],
      "clave": docRef["password"],
      "foto": docRef['foto'],
    };
    _pref.saveLocal("user", pref);
    listPelfil.clear();
    listPelfil.add(pref);
    if (listPelfil.first != null) {
      // print('aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa ${listPelfil.first["uid"]}');
      // if(docRef['ui'] != '')
      isCompleted = await perfilCompleto(listPelfil.first['uid']);
    }
    notifyListeners();
    return listPelfil;
  }

  Future<bool> registerUser(Usuario usuario, BuildContext context) async {
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text('Creando Usuario ... '),
      duration: Duration(seconds: 60),
    ));
    String doc_id = '';
    bool create = false;
    try {
      final count = await Conexion.db.collection("users").get();
      if (count.docs.isNotEmpty) {
        doc_id = 'usuario_${count.docs.length}';
        usuario.uid = count.docs.length;

      } else {
        doc_id = 'usuario_0';
      }
      final save = Conexion.db.collection('users');
      await save.doc(doc_id).set(usuario.toFirestore());

      create = true;
    } catch (error) {
      create = false;
      print('Error generando nuevo usuario: $error');
    }

    ScaffoldMessenger.of(context).hideCurrentSnackBar(); // Ocultar el SnackBar

    notifyListeners();
    return create;
  }

  Future<bool> completePerfil(UserDatails usuario, BuildContext context,
      int uidkey) async {
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text('Procesando ... '),
      duration: Duration(seconds: 60),
    ));
    String doc_id = '';
    bool create = false;

    try {
      final count = await Conexion.db.collection("perfil").get();
      if (count.docs.length >= 1) {
        doc_id = 'pelfil_${count.docs.length}';
        usuario.id =count.docs.length;

      } else{
        doc_id="pelfil_0";
      }
      usuario.uid = uidkey;
      final save = Conexion.db.collection('perfil');
      await save.doc(doc_id).set(usuario.toFirestore());
      create = true;
    } catch (error) {
      create = false;
      print('Error generando nuevo usuario: $error');
    }

    ScaffoldMessenger.of(context).hideCurrentSnackBar(); // Ocultar el SnackBar

    notifyListeners();
    return create;
  }

//ad foto al pefil del usuario
  Future<bool> EdidPerfilWithFiles(List<File> filePath,
      String documents) async {
    bool Ereturn = false;
    filePath.map((e) async {
      final Reference ref =
      Conexion.storage.ref('imagenes').child(e.path
          .split('/')
          .last);

      final UploadTask uploadTask = ref.putFile(e.absolute);

      final TaskSnapshot snapshot = await uploadTask.whenComplete(() => true);
      // print(snapshot);
      final String url = await snapshot.ref.getDownloadURL();
      if (snapshot.state == TaskState.success) {
        final docRef = Conexion.db.collection('users').doc(documents);

        /// add new foto
        await docRef.update({
          // 'foto': FieldValue.arrayRemove([""]),  //si exisye el index 0 se cra en blanco
          'foto': FieldValue.arrayUnion([url])
        });
        Ereturn = true;
        await sharedata(documents);
      } else {
        Ereturn = false;
      }
    }).toString();

    notifyListeners();
    return Ereturn;
  }

  Future<bool> authenticateAndSave() async {
    try {
      bool isBiometricSupported = await _localAuthentication.canCheckBiometrics;
      if (!isBiometricSupported) {
        // El dispositivo no admite autenticación biométrica
        return false;
      }

      bool isAuthenticated = await _localAuthentication.authenticate(
               localizedReason: 'Coloca el dedo en el lector de huellas digitales',
        options: const AuthenticationOptions(
          stickyAuth: true,
          biometricOnly: true,

        ),
      );

      if (isAuthenticated) {
        List<BiometricType> availableBiometrics =
        await _localAuthentication.getAvailableBiometrics();
        if (availableBiometrics.contains(BiometricType.strong)) {
        
          ElegantNotification.info(
              animation: AnimationType.fromTop,
              notificationPosition: NotificationPosition.center,
              toastDuration: Duration(seconds: 4),
              title: Text("Huella"),
              description: Text("Huella Registrada Puede Crear Tu Usuario"));
            return true;
        } else {
          ElegantNotification.error(
              animation: AnimationType.fromTop,
              notificationPosition: NotificationPosition.center,
              toastDuration: Duration(seconds: 4),
              title: Text("Error"),
              description: Text("El lector de huellas digitales no es compatible"));
          return false;

        }
      } else {
        ElegantNotification.error(
            animation: AnimationType.fromTop,
            notificationPosition: NotificationPosition.center,
            toastDuration: Duration(seconds: 4),
            title: Text("Error"),
            description: Text("Autenticación biométrica fallida"));
        return false;

      }
    } catch (e) {
      ElegantNotification.error(
          animation: AnimationType.fromTop,
          notificationPosition: NotificationPosition.center,
          toastDuration: Duration(seconds: 4),
          title: Text("Error"),
          description: Text("Error al autenticar mediante biométrica: $e"));
      return false;

    }
  }
}
