part of 'real_estats_bloc_bloc.dart';

abstract class RealEstatsBlocEvent extends Equatable {
  const RealEstatsBlocEvent();

  @override
  List<Object> get props => [];
}

class GetRealEstate extends RealEstatsBlocEvent {
  final String catId;
  final int selectedUrl;
  final String filterId;

  GetRealEstate({this.catId, this.filterId, this.selectedUrl});
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
