import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_storage/firebase_storage.dart';

class Conexion {
  static final Dio url = Dio();

  static final db = FirebaseFirestore.instance; //firebase
  static final FirebaseStorage storage =      FirebaseStorage.instance; //firebase para la imagenes


}
