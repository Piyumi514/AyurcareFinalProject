import 'package:ayurcare/db/repository/remedy_repo.dart';
import 'package:ayurcare/events/remedy_event.dart';
import 'package:ayurcare/state/remedy_state.dart';
import 'package:bloc/bloc.dart';

class RemedyBloc extends Bloc<RemedyEvent, RemedyState> {
  final repo = RemedyRepository();

  Future<void> loadRemedyList() async {
    final remedies = await repo.getRemedies();
    emit(RemedyState(state.remedyName, remedies));
  }

  RemedyBloc() : super(RemedyState("", [])) {
    loadRemedyList();
    on<AddRemedy>((event, emit) {
      emit(RemedyState(event.name, state.remedyList));
    });
  }
}
