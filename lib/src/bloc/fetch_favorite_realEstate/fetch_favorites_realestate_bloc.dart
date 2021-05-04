import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:dio/dio.dart';

import '../../repositories/real_estate_repo.dart';
import '../../models/real_estate_model.dart';
import '../../utils/app_constant.dart';

part 'fetch_favorites_realestate_event.dart';
part 'fetch_favorites_realestate_state.dart';

class FetchFavoritesRealestateBloc
    extends Bloc<FetchFavoritesRealestateEvent, FetchFavoritesRealestateState> {
  final RealEstateRepo realEstateRepo;
  FetchFavoritesRealestateBloc({this.realEstateRepo})
      : super(FetchFavoritesRealestateInitial());

  @override
  Stream<FetchFavoritesRealestateState> mapEventToState(
    FetchFavoritesRealestateEvent event,
  ) async* {
    if (event is FetchFavoritesRealEstate) {
      yield* _mapFetchFavoitesRealEstate(event);
    }
  }

  ///[Post RealEstate Favorites ... ]............
  Stream<FetchFavoritesRealestateState> _mapFetchFavoitesRealEstate(
      FetchFavoritesRealEstate event) async* {
    try {
      yield FetchFavoritesInProgress();
      final List<RealEstate> _realEstate =
          await realEstateRepo.fetchFavoritesRealStates(
        userId: event.userId,
      );
      yield FetchFavoritesInDone(realEstates: _realEstate);
    } on DioError catch (e) {
      final errorMassege = dioErrorType(e);
      yield FetchFavoritesInError(errorMassege: errorMassege);
    }
  }
}
