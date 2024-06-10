import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'jbstore_event.dart';
part 'jbstore_state.dart';

class JbstoreBloc extends Bloc<JbstoreEvent, JbstoreState> {
  JbstoreBloc() : super(JbstoreInitial()) {
    on<OnJbstoreCalled>((event, emit) async {
      emit(JbstoreLoading());
      await Future.delayed(const Duration(seconds: 6));
      emit(JbstoreLoaded());
    });
  }
}
