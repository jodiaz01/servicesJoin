import 'package:cloud_firestore/cloud_firestore.dart';

class Followers {
  int id;
  int  seguidorId;
  int  seguidoId;

  Followers({
    required this.id,
    required this.seguidorId,
    required this.seguidoId,

  });

  factory Followers.fromFirestore(
      DocumentSnapshot<Map<String, dynamic>> snapshot,
      SnapshotOptions? options) {
    final json = snapshot.data();
    return Followers(
      id: json?['id'],
      seguidorId: json?['seguidorId'],
      seguidoId: json?['seguidoId'],

    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'id': id ?? 0,
      'seguidorId': seguidorId ?? 0,
      'seguidoId': seguidoId ?? 0,

    };
  }
}
