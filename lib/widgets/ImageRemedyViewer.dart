import 'package:ayurcare/bloc/remedy_bloc.dart';
import 'package:ayurcare/db/models/decoction_model.dart';
import 'package:ayurcare/db/repository/decoction_repo.dart';
import 'package:ayurcare/db/repository/remedy_repo.dart';
import 'package:ayurcare/state/remedy_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ImageRemedyViewer extends StatelessWidget {
  const ImageRemedyViewer({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RemedyBloc(),
      child: ImageSwapperView(),
    );
  }
}

class ImageSwapperView extends StatefulWidget {
  const ImageSwapperView({super.key});

  @override
  _ImageSwapperState createState() => _ImageSwapperState();
}

class _ImageSwapperState extends State<ImageSwapperView> {
  List<Map<String, String>> imageDetails = [
    {
      'url': 'assets/homeremedies/Tulsi Tea.jpg',
      'details':
          'Holy basil has immune-boosting and anti-inflammatory properties. Boil fresh basil leaves in water for 10-15 minutes. Strain and drink the decoction with honey for added benefits.Ginger and Turmeric Decoction: Combine sliced ginger and turmeric powder in water and boil for 10-15 minutes. Strain and drink the decoction warm with honey for added sweetness and anti-inflammatory effects.',
      'name': 'Holy Basil (Tulsi) Decoction'
    },
    {
      'url': 'assets/homeremedies/Licorice Root.jpg',
      'details':
          'Licorice root is known for its anti-inflammatory and soothing properties. Boil licorice root in water for about 15 minutes, then strain and drink the decoction warm.Fennel Seed Decoction: Fennel seeds can help relax the bronchial muscles and reduce coughing. Boil a teaspoon of fennel seeds in water for 10 minutes. Strain and drink the decoction warm.',
      'name': 'Licorice Root Decoction'
    },
  ];

  int _selectedImageIndex = -1;
  String remedyName = "";
  List<Remedy> list = [];

  void _toggleDetails(int index) {
    setState(() {
      if (_selectedImageIndex == index) {
        _selectedImageIndex = -1;
      } else {
        _selectedImageIndex = index;
      }
    });
  }

  void getPreferances() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    remedyName = await prefs.getString('remedyName') ?? "";
    final type = await prefs.getString('type') ?? "";
    if (type == "remedy") {
      final RemedyRepository remedyRepository = RemedyRepository();
      print(remedyName);
      final listOfRemedy = await remedyRepository.getRemedyByName(remedyName);
      print(listOfRemedy.length);
      setState(() {
        list = listOfRemedy;
      });
    } else {
      final DecoctionRepo decoctionRepo = DecoctionRepo();
      print(remedyName);
      final listOfRemedy = await decoctionRepo.getRemedyByName(remedyName);
      print(listOfRemedy.length);
      setState(() {
        list = listOfRemedy;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // Accessing the BLoC
    return BlocBuilder<RemedyBloc, RemedyState>(builder: (context, state) {
      if (list.length == 0) {
        getPreferances();
      }
      if (list.length > 0) {
        return ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: list.length,
          itemBuilder: (context, index) {
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        list[index].name!,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      InkWell(
                        onTap: () {
                          _toggleDetails(index);
                        },
                        child: Image.network(
                          list[index].url!,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ],
                  ),
                ),
                if (_selectedImageIndex == index)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        list[index].details!,
                        style: const TextStyle(fontSize: 14),
                        textAlign: TextAlign.justify,
                      ),
                    ),
                  ),
                const SizedBox(height: 30),
                // Added more space between pictures
              ],
            );
          },
        );
      } else {
        return Container();
      }
    });
  }
}
