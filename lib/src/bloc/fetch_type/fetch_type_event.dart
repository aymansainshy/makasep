part of 'fetch_type_bloc.dart';

abstract class FetchTypeEvent extends Equatable {
  const FetchTypeEvent();

  @override
  List<Object> get props => [];
}

class FetchTypeNow extends FetchTypeEvent {}
