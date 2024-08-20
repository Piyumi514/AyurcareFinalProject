// ignore_for_file: camel_case_types, library_private_types_in_public_api

import 'package:animate_do/animate_do.dart';
import 'package:ayurcare/db/models/doctor_model.dart';
import 'package:ayurcare/db/repository/doctor_repo.dart';
import 'package:ayurcare/diseases/diseases_view.dart';
import 'package:ayurcare/pages/submit_page.dart';
import 'package:flutter/material.dart';

class DoctorPage extends StatefulWidget {
  final dynamic exportData;

  const DoctorPage({super.key, required this.exportData});

  @override
  _DoctorPageState createState() => _DoctorPageState();
}

class _DoctorPageState extends State<DoctorPage> {
  String? selectedDistrict;
  DoctorModel? model;

  final finalDistricts = [
    "Ampara",
    "Anuradhapura",
    "Badulla",
    "Batticaloa",
    "Colombo",
    "Galle",
    "Gampaha",
    "Hambantota",
    "Jaffna",
    "Kalutara",
    "Kandy",
    "Kegalle",
    "Kilinochchi",
    "Kurunegala",
    "Mannar",
    "Matale",
    "Matara",
    "Moneragala",
    "Nuwara Eliya",
    "Polonnaruwa",
    "Puttalam",
    "Ratnapura",
    "Trincomalee",
    "Vavuniya"
  ];

  void getDoctorDetails(String? selectedDistrict) async {
    try {
      final repo = DoctorRepository();
      final doctor = await repo.getDoctorByDistrict(selectedDistrict ?? "");
      setState(() {
        model = doctor;
      });
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: AppBar(
          leading: BackButton(
            color: Colors.white,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const DiseasesView()),
              );
            },
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset(
                'assets/ac.png', // Assuming 'logo.png' is your logo file path
                fit: BoxFit.contain,
                height: 250,
                width: 120,
              ),
            ),
          ],
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color.fromARGB(255, 25, 155, 31),
                  Color.fromARGB(255, 19, 48, 20)
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
        ),
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const SizedBox(height: 30),
            SizedBox(
              height: 250,
              child: Stack(
                children: <Widget>[
                  Center(
                    // Center widget added
                    child: Positioned(
                      height: 400,
                      width: width,
                      child: FadeInUp(
                        duration: const Duration(milliseconds: 1000),
                        child: Container(
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage('assets/doctor.jpg'),
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  FadeInUp(
                    duration: const Duration(milliseconds: 1500),
                    child: const Text(
                      "Doctor Details",
                      style: TextStyle(
                        color: Color.fromRGBO(15, 134, 39, 1),
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  FadeInUp(
                    duration: const Duration(milliseconds: 1700),
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                        border: Border.all(
                          color: const Color.fromRGBO(196, 135, 198, .3),
                        ),
                        boxShadow: const [
                          BoxShadow(
                            color: Color.fromRGBO(196, 135, 198, .3),
                            blurRadius: 20,
                            offset: Offset(0, 10),
                          ),
                        ],
                      ),
                      child: DropdownButton<String>(
                        value: selectedDistrict,
                        hint: const Text("Select District"),
                        isExpanded: true,
                        items: finalDistricts.map((String district) {
                          return DropdownMenuItem<String>(
                            value: district,
                            child: Text(district),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          getDoctorDetails(newValue);
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  model != null
                      ? FadeInUp(
                          duration: const Duration(milliseconds: 1700),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white,
                              border: Border.all(
                                color: const Color.fromRGBO(196, 135, 198, .3),
                              ),
                              boxShadow: const [
                                BoxShadow(
                                  color: Color.fromRGBO(196, 135, 198, .3),
                                  blurRadius: 20,
                                  offset: Offset(0, 10),
                                ),
                              ],
                            ),
                            child: Column(
                              children: <Widget>[
                                _buildTextField(
                                  "Doctor Name",
                                  model?.name ?? "",
                                ),
                                _buildTextField(
                                  "Specialization",
                                  model?.specialization ?? "",
                                ),
                                _buildTextField(
                                  "Medical Centre",
                                  model?.medicalCentre ?? "",
                                ),
                                _buildTextField(
                                  "Address",
                                  model?.address ?? "",
                                ),
                                _buildTextField(
                                  "Contact Info",
                                  model?.contact ?? "",
                                ),
                              ],
                            ),
                          ),
                        )
                      : const SizedBox(),
                  const SizedBox(height: 20),
                  FadeInUp(
                    duration: const Duration(milliseconds: 1700),
                    child: const Center(
                      child: Text(
                        "Connect your districtial doctor",
                        style: TextStyle(color: Color.fromRGBO(16, 144, 35, 1)),
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  FadeInUp(
                    duration: const Duration(milliseconds: 1900),
                    child: MaterialButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const MyPage(),
                          ),
                        );
                      },
                      color: const Color.fromRGBO(3, 70, 36, 1),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                      height: 50,
                      child: const Center(
                        child: Text(
                          "Home",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(String label, String value) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Color.fromRGBO(196, 135, 198, .3)),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 1, // Adjust this as necessary
            child: Text(
              "$label: ",
              style: TextStyle(
                color: Colors.grey.shade700,
                fontWeight: FontWeight.bold,
                overflow: TextOverflow.clip,
              ),
              maxLines: 2,
            ),
          ),
          Expanded(
            flex: 2, // Adjust this as necessary
            child: Text(
              value,
              style: TextStyle(
                  color: Colors.grey.shade700, overflow: TextOverflow.clip),
              maxLines: 2,
            ),
          ),
        ],
      ),
    );
  }
}
