part of 'post_favorites_bloc.dart';

abstract class PostFavoritesState extends Equatable {
  const PostFavoritesState();

  @override
  List<Object> get props => [];
}

class PostFavoritesInitial extends PostFavoritesState {}

class PostFavoritesInProgress extends PostFavoritesState {}

class PostFavoritesDone extends PostFavoritesState {}

class PostFavoritesError extends PostFavoritesState {
  final String errorMassege;

  PostFavoritesError({this.errorMassege});
}
