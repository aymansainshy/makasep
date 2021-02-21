part of 'fetch_type_bloc.dart';

abstract class FetchTypeState extends Equatable {
  const FetchTypeState();

  @override
  List<Object> get props => [];
}

class FetchTypeInitial extends FetchTypeState {}

class FetchTypeInProgress extends FetchTypeState {}

class FetchTypeDone extends FetchTypeState {
  final List<SecondryType> typeList;

  FetchTypeDone({this.typeList});
}

class FetchTypeError extends FetchTypeState {}
