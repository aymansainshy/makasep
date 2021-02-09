part of 'post_favorites_bloc.dart';

abstract class PostFavoritesEvent extends Equatable {
  const PostFavoritesEvent();

  @override
  List<Object> get props => [];
}

class PostFavoriteRealEstate extends PostFavoritesEvent {
  final String realEstatsId;
  final String userId;

  PostFavoriteRealEstate({this.realEstatsId, this.userId});
}
