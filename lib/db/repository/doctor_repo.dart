import 'package:ayurcare/db/models/doctor_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DoctorRepository {
  final CollectionReference _doctorsCollection =
      FirebaseFirestore.instance.collection('doctors');

  // final list = [
  //   {
  //     'name': 'Dr. Isuru Liyanage',
  //     'district': 'Ampara',
  //     'specialization': 'General Physician',
  //     'medicalCentre': 'Ayurvedic Research Hospital',
  //     'address': 'Ayurvedic Research Hospital, Ampara',
  //     'contact': '0632224349'
  //   },
  //   {
  //     'name': 'Dr. Thilini Perera',
  //     'district': 'Anuradhapura',
  //     'specialization': 'General Physician',
  //     'medicalCentre': 'Ayurweda Medical Center',
  //     'address': '309, Devana Piyawara, Thambuttegama',
  //     'contact': '0718855940'
  //   },
  //   {
  //     'name': 'Dr. Gayathri Madumani',
  //     'district': 'Badulla',
  //     'specialization': 'General Physician',
  //     'medicalCentre': 'Gampaha Ayurweda Medical Center',
  //     'address': 'Haldummulla, Haputale, Sri Lanka',
  //     'contact': '0704041699'
  //   },
  //   {
  //     'name': 'Dr. Thusya Yathies',
  //     'district': 'Batticaloa',
  //     'specialization': 'General Physician',
  //     'medicalCentre': 'Borella Ayurvedic Hospital',
  //     'address': 'Borella Ayurvedic Hospital, Batticaloa',
  //     'contact': '065 2222678'
  //   },
  //   {
  //     'name': 'Dr. K A D Keeshani Randima',
  //     'district': 'Colombo',
  //     'specialization': 'General Physician',
  //     'medicalCentre': 'Ayurdhara Ayurwedic Medical Center',
  //     'address': 'No. 102G Bangalawata, Kothalawala, Kaduwela',
  //     'contact': '0771383439'
  //   },
  //   {
  //     'name': 'Dr. Oshini Siriwardhana',
  //     'district': 'Galle',
  //     'specialization': 'General Physician',
  //     'medicalCentre': '',
  //     'address': '86/2 Wakwella rd, Galle',
  //     'contact': '0778634089'
  //   },
  //   {
  //     'name': 'Dr. R. M. D Sasrika',
  //     'district': 'Gampaha',
  //     'specialization': 'General Physician',
  //     'medicalCentre': 'Seth AYU Medical Center',
  //     'address': '247/1, Pahala Karagahamuna, Kadawatha',
  //     'contact': '0773756563'
  //   },
  //   {
  //     'name': 'Dr. Athma Karunathilaka',
  //     'district': 'Hambantota',
  //     'specialization': 'General Physician',
  //     'medicalCentre': 'Ayurvedic Research Hospital',
  //     'address': 'Siribopura, Hambantota',
  //     'contact': '047-2256700'
  //   },
  //   {
  //     'name': 'Dr. (Mrs.) S. Thurairatnam',
  //     'district': 'Jaffna',
  //     'specialization': 'General Physician',
  //     'medicalCentre': 'Siddha Teaching Hospital',
  //     'address': 'Kaithady, Kandy Road',
  //     'contact': '0212057104'
  //   },
  //   {
  //     'name': 'Dr. Chamari Adihetti',
  //     'district': 'Kalutara',
  //     'specialization': 'General Physician',
  //     'medicalCentre': 'Ayurwedic Medical Center',
  //     'address': '247/1, Pahala Karagahamuna, Kadawatha',
  //     'contact': '0712393687'
  //   },
  //   {
  //     'name': 'Dr. Harshana Dissanayake',
  //     'district': 'Kandy',
  //     'specialization': 'General Physician',
  //     'medicalCentre': 'Jeewaka Ayurweda',
  //     'address': 'Kandy Road, Hasalaka',
  //     'contact': '0714541705'
  //   },
  //   {
  //     'name': 'Dr. Hansani Wimalasena',
  //     'district': 'Kegalle',
  //     'specialization': 'General Physician',
  //     'medicalCentre': 'Ayushveda - Ayurweda & Wellness',
  //     'address': 'No. 37, Kandy Road, Kegalle',
  //     'contact': '0774166864'
  //   },
  //   {
  //     'name': 'Dr. P. Karunja',
  //     'district': 'Kilinochchi',
  //     'specialization': 'General Physician',
  //     'medicalCentre': 'HDU, DGH Chilaw',
  //     'address': 'RDHS Division, Kilinochchi',
  //     'contact': '0718561596'
  //   },
  //   {
  //     'name': 'Dr. Udith',
  //     'district': 'Kurunegala',
  //     'specialization': 'General Physician',
  //     'medicalCentre': 'Ayurwedic Medical Center',
  //     'address': 'Kurunegala, Pothuhera',
  //     'contact': '0772656131'
  //   },
  //   {
  //     'name': 'Dr. Thiyananthan Thinesh',
  //     'district': 'Mannar',
  //     'specialization': 'General Physician',
  //     'medicalCentre': 'SURYA Ayurveda Hospital & YOGA Centre',
  //     'address': 'SURYA Ayurveda Hospital, Mannar',
  //     'contact': '0767315797'
  //   },
  //   {
  //     'name': 'Dr. Dimitri Darshika',
  //     'district': 'Matale',
  //     'specialization': 'General Physician',
  //     'medicalCentre': 'Deegayush Ayurweda Medical Center',
  //     'address': 'No. 15 Rose Street, Matale',
  //     'contact': '0763925388'
  //   },
  //   {
  //     'name': 'M.D.M Warnathilaka',
  //     'district': 'Matara',
  //     'specialization': 'General Physician',
  //     'medicalCentre': 'Sakya Traditional Ayurweda Hospital',
  //     'address': 'No: 678, Matara 81000',
  //     'contact': '0412 244 833'
  //   },
  //   {
  //     'name': 'Dr. Indika Nuwan',
  //     'district': 'Moneragala',
  //     'specialization': 'General Physician',
  //     'medicalCentre': 'Gampaha Ayurweda Medical Center',
  //     'address': 'Haputale Road, Wallawaya',
  //     'contact': '0719178775'
  //   },
  //   {
  //     'name': 'Dr. Tharanga Weerathunga',
  //     'district': 'Nuwara Eliya',
  //     'specialization': 'General Physician',
  //     'medicalCentre': 'Thilaka Treatment Ayurveda Center',
  //     'address': 'No. 22 Lady Mc Cullum\'s Drive, Lady McClums Dr',
  //     'contact': '071 084 7522'
  //   },
  //   {
  //     'name': 'Dr. W.S.D. Sooriya Bandara',
  //     'district': 'Polonnaruwa',
  //     'specialization': 'General Physician',
  //     'medicalCentre': 'Rural Ayurveda Hospital',
  //     'address': 'Rural Ayurveda Hospital, Siripura',
  //     'contact': '00272-0537'
  //   },
  //   {
  //     'name': 'Dr. N M U Madhubhashini',
  //     'district': 'Puttalam',
  //     'specialization': 'General Physician',
  //     'medicalCentre': 'Sukayu Ayurweda Medical Center',
  //     'address': 'Newtown, Madampe',
  //     'contact': '0710647771'
  //   },
  //   {
  //     'name': 'Dr. D G N Awanthi',
  //     'district': 'Ratnapura',
  //     'specialization': 'General Physician',
  //     'medicalCentre': 'Sumethma Ayurwedic Medical Center',
  //     'address': 'Thelwatte, Mudduwa, Rathnapura',
  //     'contact': '0773572530'
  //   },
  //   {
  //     'name': 'Dr. Chamil Karunarathna',
  //     'district': 'Trincomalee',
  //     'specialization': 'General Physician',
  //     'medicalCentre': 'Trinco Ayurweda Clinic',
  //     'address': 'Kandy Road, Trincomalee',
  //     'contact': '0713784039'
  //   },
  //   {
  //     'name': 'Dr. Thambippillai Krishnapahavan',
  //     'district': 'Vavuniya',
  //     'specialization': 'General Physician',
  //     'medicalCentre': 'Krishna Siddha Ayurveda Vaidyasalai',
  //     'address': 'No-11, 3rd Cross Street, Kandy Road',
  //     'contact': '071 210 2913'
  //   }
  // ];
  //
  // Future<void> addAll() async {
  //   for (var item in list) {
  //     final doctorModel = DoctorModel(
  //       address: item["address"] ?? "",
  //       name: item["name"] ?? "",
  //       district: item["district"] ?? "",
  //       specialization: item["specialization"] ?? "",
  //       medicalCentre: item["medicalCentre"] ?? "",
  //       contact: item["contact"] ?? "",
  //     );
  //     await addDoctor(doctorModel);
  //   }
  // }

  // Fetch all doctors
  Future<List<DoctorModel>> getAllDoctors() async {
    try {
      QuerySnapshot snapshot = await _doctorsCollection.get();
      return snapshot.docs
          .map(
              (doc) => DoctorModel.fromJson(doc.data() as Map<String, dynamic>))
          .toList();
    } catch (e) {
      print('Error getting doctors: $e');
      return [];
    }
  }

  // Fetch a doctor by ID
  Future<DoctorModel?> getDoctorByDistrict(String district) async {
    try {
      final doc =
          await _doctorsCollection.where("district", isEqualTo: district).get();
      return doc.docs
          .map(
              (doc) => DoctorModel.fromJson(doc.data() as Map<String, dynamic>))
          .toList()
          .first;
    } catch (e) {
      print('Error getting doctor: $e');
      return null;
    }
  }

  // Add a new doctor
  Future<void> addDoctor(DoctorModel doctor) async {
    try {
      await _doctorsCollection.add(doctor.toJson());
      print("Doctor Added!");
    } catch (e) {
      print('Error adding doctor: $e');
    }
  }

  // Update an existing doctor
  Future<void> updateDoctor(String id, DoctorModel doctor) async {
    try {
      await _doctorsCollection.doc(id).update(doctor.toJson());
    } catch (e) {
      print('Error updating doctor: $e');
    }
  }

  // Delete a doctor
  Future<void> deleteDoctor(String id) async {
    try {
      await _doctorsCollection.doc(id).delete();
    } catch (e) {
      print('Error deleting doctor: $e');
    }
  }
}
