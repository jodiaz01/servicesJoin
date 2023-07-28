import 'package:cloud_firestore/cloud_firestore.dart';
enum PostAudience {
  client,
  public,
  private,
}
class UserPost {
  int id;
  int? uid;// usaurio o servidor quien postea
  List<String> ? cliente; // los cliente han marcado el post como favorito o su cliente de contacto
  String titulo;
  String descripcion;
  double ? costo;
  DateTime fecha;
  List<String>  img;
  List<String> ? video;
  PostAudience ? audience; //saber commo se guardo el post

  UserPost(
      {
        required this.id,
        this.uid,
        this.cliente,
        required this.titulo,
        required this.descripcion,
        this.costo,
        required this.fecha,
        required this.img,
        this.video,
        this.audience
      });

  factory UserPost.fromFirestore(
      DocumentSnapshot<Map<String, dynamic>> snapshot,
      SnapshotOptions? options) {
    final json = snapshot.data();
    return UserPost(
      id: json?['id'],
      uid: json?['uid'],
      cliente: json?['cliente'] is Iterable ? List.from(json?['cliente']):[],
      titulo: json?['titulo'],
      descripcion: json?['descripcion'],
      costo: json?['costo'],
      fecha:  json?['fecha'] != null
          ? DateTime.parse(json?["fecha"])
          : DateTime.now(),
      img: json?['img'] is Iterable ? List.from(json ?['img']): [],
      video: json?['video'] is Iterable ? List.from(json ?['video']): [],
      audience: json?['audience']

    );

  }

  Map<String, dynamic> toFirestore() {
    return {
      'id': id ?? 0,
      'uid': uid ?? 0,
      'cliente': cliente??[],
      'titulo': titulo ?? '',
      'descripcion':descripcion ?? '',
      'costo': costo ?? 0,
      'fecha':fecha.toIso8601String(),
      'img': img ?? [],
      'video': video ?? [],
      'audience': audience??''
    };
  }
}
