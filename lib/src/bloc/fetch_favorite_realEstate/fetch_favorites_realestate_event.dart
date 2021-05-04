part of 'fetch_favorites_realestate_bloc.dart';

abstract class FetchFavoritesRealestateEvent extends Equatable {
  const FetchFavoritesRealestateEvent();

  @override
  List<Object> get props => [];
}

class FetchFavoritesRealEstate extends FetchFavoritesRealestateEvent {
  final String userId;

  FetchFavoritesRealEstate({this.userId});
}
