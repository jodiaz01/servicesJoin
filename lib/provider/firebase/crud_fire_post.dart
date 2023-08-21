import 'dart:io';
import 'package:ServiPro/models/follower_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elegant_notification/elegant_notification.dart';
import 'package:elegant_notification/resources/arrays.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:ServiPro/conexion/server.dart';
import 'package:ServiPro/models/user_post.dart';

class FirebasePost extends ChangeNotifier {
  List dataPost = [];
  List<dynamic> Lsfollow = [];

  FirebasePost() {
    readPoster();
    notifyListeners();
  }

  Future<bool> addPostofire(UserPost poster, BuildContext context, int uidkey,
      List<File> filePath) async {


    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text('Procesando ... '),
      duration: Duration(seconds: 60),
    ));
    String docId = '';
    bool create = false;
    try {
      final count = await Conexion.db.collection("post").get();
      if (count.docs.length <= 0) {
        docId = "post_0";
      } else {
        docId = 'post_${count.docs.length}';
        poster.id = count.docs.length;
      }
      poster.uid = uidkey;

      /*----------------------------------------------------------*/

      filePath.map((e) async {
        final Reference ref =
            Conexion.storage.ref('poster').child(e.path.split('/').last);

        final UploadTask uploadTask = ref.putFile(e.absolute);

        final TaskSnapshot snapshot = await uploadTask.whenComplete(() => true);
        final String url = await snapshot.ref.getDownloadURL();
        if (snapshot.state == TaskState.success) {
          final documentos =
              Conexion.db.collection('post').doc(docId.toString());
          if (url.contains('.mp4')) {
            await documentos.update({
              "video": FieldValue.arrayUnion([url])
            });
          } else {
            await documentos.update({
              "img": FieldValue.arrayUnion([url])
            });
          }
        }
      }).toString();

      final save = Conexion.db.collection('post');
      await save.doc(docId).set(poster.toFirestore());
      create = true;
      readPoster();
    } catch (error) {
      create = false;
      print('Error generando nuevo Poster: $error');
    }

    ScaffoldMessenger.of(context).hideCurrentSnackBar(); // Ocultar el SnackBar

    notifyListeners();
    return create;
  }

  //implemetar para los seguidores
  Future<bool> seguirPoster(
      idDocument, cliente, String? usertoSeguir, uid, fid) async {
    String doc_id = '';

    try {
      final autoId = await Conexion.db.collection('follower').get();
      if (autoId.docs.isNotEmpty) {
        doc_id = 'fwr_${autoId.docs.length}';
      } else {
        doc_id = 'fwr_0';
      }

      Followers followers = Followers(
          id: autoId.docs.length,
          seguidoId: int.parse(uid),
          seguidorId: int.parse(fid));

      final save = Conexion.db.collection('follower');
      await save
          .doc(doc_id)
          .set(followers.toFirestore())
          .onError((error, stackTrace) => false);

      final docUpdate =
          Conexion.db.collection('post').doc(idDocument.toString());

      await docUpdate.update({
        'cliente': FieldValue.arrayUnion([cliente]),
      });

      return true;
    } catch (e) {
      print('Errrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrr$e');
      return false;
    }
  }

  Future<List<dynamic>> readPoster() async {
    try {
      // int Idp = userId !='' && userId != 'uid' ? int.parse(userId.toString().trim()) : 0;
      //     var data = await Conexion.db.collection('post').where('uid', isEqualTo:Idp).get();

      await Conexion.db
          .collection('follower')
          .get()
          .then((value) {
            if(value.docs.isNotEmpty)Lsfollow.clear();
            return value.docs.map((e) {

          // Lsfollow.add(e.data()['Uid']);
          Lsfollow.add(e.data());
          // Lsfollow.add(e.data()['followId']);
             // Lsfollow.add(e.data()['misseguidores']);
             // Lsfollow.add(e.data()['siguiendo']);
              }).toList();
          });
      // if(isonfollower.docs.isNotEmpty) {
      //   // list.add(isonfollower.docs.first.id);
      //
      //
      // }
      final usuariomap = await Conexion.db
          .collection('users')
          .where('is_active', isEqualTo: true)
          .get();
      if (usuariomap.docs.isNotEmpty) dataPost.clear();

      for (var docSnapshot in usuariomap.docs) {
        final collet = await Conexion.db
            .collection('post')
            .where('uid', isEqualTo: docSnapshot.data()['uid'])
            .orderBy('id', descending: true)
            .get();

        collet.docs.map((e) async {
          final map = {
            "nombre":
                "${docSnapshot.data()['first_name']}, ${docSnapshot.data()['last_name']}",
            "usuario": docSnapshot.data()['username'],
            "uid": e.data()['uid'],
            "titulo": e.data()['titulo'],
            "costo": e.data()['costo'],
            "descripcion": e.data()['descripcion'],
            "fecha": e.data()['fecha'],
            "img": e.data()['img'],
            "video": e.data()['video'],
            'avatar': docSnapshot.data()['foto'],
            'estado': e.data()['audience'],
            'likes': e.data()['likes'],
            'documents': e.id,
          };
          dataPost.add(map);
        }).toList();
      }
      // print(dataPost);

      notifyListeners();
      return dataPost;
    } catch (e) {
      return [];
    }
  }
}
