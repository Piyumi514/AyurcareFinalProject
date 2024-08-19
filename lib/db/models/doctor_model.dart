class DoctorModel {
  final String name;
  final String district;
  final String specialization;
  final String medicalCentre;
  final String address;
  final String contact;

  DoctorModel({
    required this.name,
    required this.district,
    required this.specialization,
    required this.medicalCentre,
    required this.address,
    required this.contact,
  });

  // Factory constructor to create a Doctor object from JSON
  factory DoctorModel.fromJson(Map<String, dynamic> json) {
    return DoctorModel(
      name: json['name'] as String,
      district: json['district'] as String,
      specialization: json['specialization'] as String,
      medicalCentre: json['medicalCentre'] as String,
      address: json['address'] as String,
      contact: json['contact'] as String,
    );
  }

  // Method to convert Doctor object to JSON
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'district': district,
      'specialization': specialization,
      'medicalCentre': medicalCentre,
      'address': address,
      'contact': contact,
    };
  }
}
