import 'package:cloud_firestore/cloud_firestore.dart';

class DiseasesModel {
  final String diseasesName;
  final String details;

  DiseasesModel({
    required this.diseasesName,
    required this.details,
  });

  factory DiseasesModel.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data() as Map<String, dynamic>;
    return DiseasesModel(
        diseasesName: data['diseases_name'] ?? '',
        details: data['details'] ?? '');
  }

  Map<String, dynamic> toMap() {
    return {
      'diseases_name': diseasesName,
      'details': details,
    };
  }
}
