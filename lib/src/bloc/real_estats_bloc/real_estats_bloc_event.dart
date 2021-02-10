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

class FetchSamilerRealEstate extends RealEstatsBlocEvent {
  final String realEstateId;

  FetchSamilerRealEstate({this.realEstateId});
}

class FetchLastCallRealEstate extends RealEstatsBlocEvent {
  final String userId;

  FetchLastCallRealEstate({this.userId});
}

class FetchTodayRealEstate extends RealEstatsBlocEvent {
  FetchTodayRealEstate();
}

class FetchSpecialRealEstate extends RealEstatsBlocEvent {
  FetchSpecialRealEstate();
}

class PostRealEstate extends RealEstatsBlocEvent {
  final RealEstate realEstats;
  final String userId;
  final File image;

  PostRealEstate({this.realEstats, this.image, this.userId});
}
