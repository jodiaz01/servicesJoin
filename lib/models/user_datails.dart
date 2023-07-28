import 'package:cloud_firestore/cloud_firestore.dart';

class UserDatails {
  int id;
  int? uid;
  String servicio;
  String detalle_servicio;
  int esperiencia; //0 1 ano 30 dia etc
  String tiempo; //semana dias, mese  anos
  String contacto;
  String? otro_contacto;
  String? rede_social;
  String ciudad;
  String? sector_barrio;
  String direcion_ubicacion;
  String sexo;
  int edad;

  // List<String> ? foto;


  UserDatails({required this.id,
    this.uid,
    required this.servicio,
    required this.detalle_servicio,
    required this.esperiencia,
    required this.tiempo,
    required this.contacto,
    this.otro_contacto,
    this.rede_social,
    required this.ciudad,
    this.sector_barrio,
    required this.direcion_ubicacion,
    required this.sexo,
    required this.edad,
    // this.foto,
  });

  factory UserDatails.fromFirestore(
      DocumentSnapshot<Map<String, dynamic>> snapshot,
      SnapshotOptions? options) {
    final json = snapshot.data();
    return UserDatails(
      id: json?['id'],
      uid: json?['uid'],
      servicio: json?['servicio'],
      detalle_servicio: json?['detalle_servicio'],
      esperiencia: json?['esperiencia'],
      tiempo: json?['tiempo'],
      contacto: json?['contacto'],
      otro_contacto: json?['otro_contacto'],
      rede_social: json?['rede_social'],
      ciudad: json?['ciudad'],
      sector_barrio: json?['sector_barrio'],
      direcion_ubicacion: json?['direcion_ubicacion'],
      sexo: json?['sexo'],
      edad: json?['edad'],
      // foto: json?['foto'] is Iterable ? List.from(json ?['foto']): []

    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'id': id ?? 0,
      'uid': uid ?? 0,
      'servicio': servicio ?? '',
      'detalle_servicio': detalle_servicio ?? '',
      'esperiencia': esperiencia ?? '',
      'tiempo': tiempo ?? 0,
      'contacto': contacto ?? '',
      'otro_contacto': otro_contacto ?? '',
      'rede_social': rede_social ?? '',
      'ciudad': ciudad ?? '',
      'sector_barrio': sector_barrio ?? '',
      'direcion_ubicacion': direcion_ubicacion ?? '',
      'sexo': sexo ?? '',
      'edad': edad ?? 0,
      // 'foto': foto ?? [],
    };
  }
}
/// solo para leer losdatos
class UserCombine {
  String nombre;
  String usuario;
  List<String> avatar;
  String servicio;
  String detalle_servicio;
  int esperiencia;
  String tiempo;
  String contacto;
  String ? otro_contacto;
  String ?rede_social;
  String ciudad;
  String ?sector_barrio;
  String ?direcion_ubicacion;
  String sexo;
  int edad;

  UserCombine(this.nombre,
      this.usuario,
      this.avatar,
      this.servicio,
      this.detalle_servicio,
      this.esperiencia,
      this.tiempo,
      this.contacto,
      this.otro_contacto,
      this.rede_social,
      this.ciudad,
      this.sector_barrio,
      this.direcion_ubicacion,
      this.sexo,
      this.edad);

  Map<String, dynamic> toCombine() {
    return {
      "nombre": nombre ?? '',
      "usuario": usuario ?? '',
      "avatar": avatar ?? [],
      "servicio": servicio ?? '',
      "detalle_servicio": detalle_servicio ?? '',
      "esperiencia": esperiencia??0,
      "tiempo": tiempo?? '',
      "contacto": contacto ?? '',
      "otro_contacto": otro_contacto ?? '',
      "rede_social": rede_social ?? '',
      "ciudad": ciudad ?? '',
      "sector_barrio": sector_barrio ?? '',
      "direcion_ubicacion": direcion_ubicacion ?? '',
      "sexo": sexo ?? '',
      "edad": edad ?? 0,

    };
  }
}