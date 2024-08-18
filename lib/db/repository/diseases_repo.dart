import 'package:ayurcare/db/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/diseases_model.dart';

class DiseasesRepo {
  final CollectionReference _diseasesCollection =
  FirebaseFirestore.instance.collection('diseases');

  // void addListToFirestore() {
  //   for (String item in list) {
  //     try {
  //       addDiseases(new DiseasesModel(diseasesName: item));
  //     } catch (e) {
  //     }
  //   }
  // }

  Future<void> addDiseases(DiseasesModel disease) async {
    try {
      await _diseasesCollection.add({
        'diseases_name': disease.diseasesName
      });
      print('Disease added successfully');
    } catch (e) {
      print('Error adding disease: $e');
    }
  }

  Future<List<DiseasesModel>> getDiseases() async {
    try {
      QuerySnapshot querySnapshot = await _diseasesCollection.get();
      return querySnapshot.docs
          .map((doc) => DiseasesModel.fromFirestore(doc))
          .toList();
    } catch (e) {
      print('Error getting disease: $e');
      return [];
    }
  }

  Future<void> updateDiseases(DiseasesModel disease) async {
    try {
      await _diseasesCollection
          .doc(disease.diseasesName)
          .update(disease.toMap());
      print('disease updated successfully');
    } catch (e) {
      print('Error updating disease: $e');
    }
  }

  Future<void> deleteDiseases(String id) async {
    try {
      await _diseasesCollection.doc(id).delete();
      print('disease deleted successfully');
    } catch (e) {
      print('Error deleting disease: $e');
    }
  }
}