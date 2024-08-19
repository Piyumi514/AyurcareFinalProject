import 'package:ayurcare/db/models/decoction_model.dart';

class RemedyState {
  final String remedyName;
  final List<Remedy> remedyList;

  RemedyState(this.remedyName, this.remedyList);
}
