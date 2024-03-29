part of 'semilar_real_estate_bloc.dart';

abstract class SemilarRealEstateEvent extends Equatable {
  const SemilarRealEstateEvent();

  @override
  List<Object> get props => [];
}

class FetchSemilarRealEstate extends SemilarRealEstateEvent {
  final int realEstateId;

  FetchSemilarRealEstate({this.realEstateId});
}
