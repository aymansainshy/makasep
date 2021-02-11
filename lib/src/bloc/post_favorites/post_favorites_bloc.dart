import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../models/real_estate_model.dart';
import '../../repositories/real_estate_repo.dart';

part 'post_favorites_event.dart';
part 'post_favorites_state.dart';

class PostFavoritesBloc extends Bloc<PostFavoritesEvent, PostFavoritesState> {
  final RealEstateRepo realEstateRepo;
  PostFavoritesBloc({this.realEstateRepo}) : super(PostFavoritesInitial());

  @override
  Stream<PostFavoritesState> mapEventToState(
    PostFavoritesEvent event,
  ) async* {
    if (event is PostFavoriteRealEstate) {
      yield* _mapPostFavoitesRealEstate(event);
    } else if (event is FetchFavoritesRealEstate) {
      yield* _mapFetchFavoitesRealEstate(event);
    }
  }

  ///[Post RealEstate Favorites ... ]............
  Stream<PostFavoritesState> _mapPostFavoitesRealEstate(
      PostFavoriteRealEstate event) async* {
    try {
      yield PostFavoritesInProgress();
      await realEstateRepo.postFavoriteRealEstate(
        realEstateId: event.realEstatsId,
        usetId: event.userId,
      );
      yield PostFavoritesDone();
    } catch (e) {
      yield PostFavoritesError(errorMassege: e.toString());
    }
  }

  ///[Post RealEstate Favorites ... ]............
  Stream<PostFavoritesState> _mapFetchFavoitesRealEstate(
      FetchFavoritesRealEstate event) async* {
    try {
      yield PostFavoritesInProgress();
      final List<RealEstate> _realEstate =
          await realEstateRepo.fetchFavoritesRealStates(
        userId: event.userId,
      );
      yield FetchFavoritesDone(realEstates: _realEstate);
    } catch (e) {
      yield PostFavoritesError(errorMassege: e.toString());
    }
  }
}
