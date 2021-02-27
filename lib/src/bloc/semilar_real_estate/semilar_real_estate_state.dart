part of 'semilar_real_estate_bloc.dart';

abstract class SemilarRealEstateState extends Equatable {
  const SemilarRealEstateState();

  @override
  List<Object> get props => [];
}

class SemilarRealEstateInitial extends SemilarRealEstateState {}

class SemilarRealEstateInProgress extends SemilarRealEstateState {}

class SemilarRealEstateLoadingDone extends SemilarRealEstateState {
  final List<RealEstate> realEstates;
  final User userData;

  SemilarRealEstateLoadingDone({this.realEstates, this.userData});
  @override
  List<Object> get props => [realEstates, userData];
}

class SemilarRealEstateError extends SemilarRealEstateState {
  final String errorMassage;

  SemilarRealEstateError({this.errorMassage});
}
