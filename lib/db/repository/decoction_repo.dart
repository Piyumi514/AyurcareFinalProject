import 'package:ayurcare/db/models/decoction_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DecoctionRepo {
  final CollectionReference collection = FirebaseFirestore.instance.collection('decoctions');

  // Fetch all remedies
  Future<List<Remedy>> getRemedies() async {
    try {
      QuerySnapshot querySnapshot = await collection.get();
      return querySnapshot.docs
          .map((doc) => Remedy.fromMap(doc.data() as Map<String, dynamic>))
          .toList();
    } catch (e) {
      throw Exception('Error getting remedies: $e');
    }
  }

  // Fetch a single remedy by document ID
  Future<List<Remedy>> getRemedyByName(String name) async {
    try {
      var query = await collection.where("disease", isEqualTo: name).get();
      return query.docs
          .map((doc) => Remedy.fromMap(doc.data() as Map<String, dynamic>))
          .toList();
    } catch (e) {
      throw Exception('Error getting remedy: $e');
    }
  }

  // Add a new remedy
  Future<void> addRemedy(Remedy remedy) async {
    try {
      await collection.add(remedy.toMap());
    } catch (e) {
      throw Exception('Error adding remedy: $e');
    }
  }

  // Update an existing remedy by document ID
  Future<void> updateRemedy(String id, Remedy remedy) async {
    try {
      await collection.doc(id).update(remedy.toMap());
    } catch (e) {
      throw Exception('Error updating remedy: $e');
    }
  }

  // Delete a remedy by document ID
  Future<void> deleteRemedy(String id) async {
    try {
      await collection.doc(id).delete();
    } catch (e) {
      throw Exception('Error deleting remedy: $e');
    }
  }
}
