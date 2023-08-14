import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class Usuario {
  Usuario({
    this.uid,
    required this.tipo,
    required this.firstName,
    required this.lastName,
    required this.username,
    required this.password,
    this.biometric,
    required this.email,
    required this.isActive,
    required this.lastLogin,
    required this.dateJoined,
    this.foto,
    // this.totalCart
  });

  int ? uid;
  String tipo;
  String firstName;
  String lastName;
  String username;
  String password;
  bool ? biometric;
  String email;
  bool isActive;
  DateTime? lastLogin;
  DateTime dateJoined;
 List<String> ? foto;



  factory Usuario.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final json = snapshot.data();
    return Usuario(
        uid: json?["uid"],
        tipo: json?["tipo"],
        firstName: json?["first_name"],
        lastName: json?["last_name"],
        username: json?["username"],
        password: json?["password"],
        biometric: json?["biometric"],
        email: json?["email"],
        isActive: json?["isActive"],
        lastLogin: json?['last_login'] != null
            ? DateTime.parse(json?["last_login"])
            : DateTime.now(),
        dateJoined: DateTime.parse(json?["date_joined"]),
        foto: json?['foto'] is Iterable ? List.from(json ?['foto']): []);
  }

  Map<String, dynamic> toFirestore() {
    return {
      "uid": uid ?? 0,
      "tipo": tipo ?? '',
      "first_name": firstName ?? '',
      "last_name": lastName ?? '',
      "username": username ?? '',
      "password": password ?? '',
      "biometric": biometric ?? false,
      "email": email ?? '',
      "is_active": isActive,
      "last_login": lastLogin?.toIso8601String(),
      "date_joined": dateJoined.toIso8601String(),
      'foto': foto ?? [],

    };
  }

}

