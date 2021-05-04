part of 'fetch_favorites_realestate_bloc.dart';

abstract class FetchFavoritesRealestateState extends Equatable {
  const FetchFavoritesRealestateState();

  @override
  List<Object> get props => [];
}

class FetchFavoritesRealestateInitial extends FetchFavoritesRealestateState {}

class FetchFavoritesInProgress extends FetchFavoritesRealestateState {}

class FetchFavoritesInDone extends FetchFavoritesRealestateState {
  final List<RealEstate> realEstates;

  FetchFavoritesInDone({this.realEstates});
}

class FetchFavoritesInError extends FetchFavoritesRealestateState {
  final String errorMassege;

  FetchFavoritesInError({this.errorMassege});
}
