part of 'jbstore_bloc.dart';

@immutable
sealed class JbstoreState {}

final class JbstoreInitial extends JbstoreState {}

final class JbstoreLoading extends JbstoreState {}

final class JbstoreLoaded extends JbstoreState {}
