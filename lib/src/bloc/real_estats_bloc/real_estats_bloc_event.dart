part of 'real_estats_bloc_bloc.dart';

abstract class RealEstatsBlocEvent extends Equatable {
  const RealEstatsBlocEvent();

  @override
  List<Object> get props => [];
}

class FetchRealEstate extends RealEstatsBlocEvent {
  final String catId;
  final int selectedUrl;
  final String filterId;

  FetchRealEstate({this.catId, this.filterId, this.selectedUrl});
}

class FetchAndFilterRealEstat extends RealEstatsBlocEvent {
  // final List<RealEstate> realEstats;

  // FetchAndFilterRealEstat({this.realEstats});
}
