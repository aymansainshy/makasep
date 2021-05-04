part of 'real_estats_bloc_bloc.dart';

abstract class RealEstatsBlocState extends Equatable {
  const RealEstatsBlocState();

  @override
  List<Object> get props => [];
}

class RealEstatsInitial extends RealEstatsBlocState {}

class RealEstatsLoading extends RealEstatsBlocState {}

class RealEstatsLoaded extends RealEstatsBlocState {
  final List<RealEstate> realEstats;

  RealEstatsLoaded({this.realEstats});
}

class RealEstatsError extends RealEstatsBlocState {
  final String errorMassage;

  RealEstatsError({this.errorMassage});
}

class RealEstatsPosted extends RealEstatsBlocState {}
