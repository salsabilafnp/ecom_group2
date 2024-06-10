part of 'jbstore_bloc.dart';

@immutable
sealed class JbstoreEvent {}

class OnJbstoreCalled extends JbstoreEvent {}
