import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../models/real_estate_model.dart';
import '../../repositories/real_estate_repo.dart';

part 'real_estats_bloc_event.dart';
part 'real_estats_bloc_state.dart';

class RealEstatsBlocBloc
    extends Bloc<RealEstatsBlocEvent, RealEstatsBlocState> {
  final RealEstateRepo realEstateRepo;

  RealEstatsBlocBloc({this.realEstateRepo}) : super(RealEstatsInitial());

  @override
  Stream<RealEstatsBlocState> mapEventToState(
      RealEstatsBlocEvent event) async* {
    if (event is FetchRealEstate) {
      yield* _mapFetchRealEstate(event);
    } else if (event is FetchSamilerRealEstate) {
      yield* _mapFetchSemilerRealEstate(event);
    } else if (event is FetchLastCallRealEstate) {
      yield* _mapFetchLastCallRealEstate(event);
    } else if (event is FetchTodayRealEstate) {
      yield* _mapFetchTodayRealEstate(event);
    } else if (event is FetchSpecialRealEstate) {
      yield* _mapFetchEspecialRealEstate(event);
    } else if (event is PostRealEstate) {
      yield* _mapPostRealEstate(event);
    }
  }

  ///[All RealEstate ... ]............
  Stream<RealEstatsBlocState> _mapFetchRealEstate(
      FetchRealEstate event) async* {
    yield RealEstatsLoading();
    final List<RealEstate> realEstats = await realEstateRepo.fetchRealStates(
        event.catId, event.filterId, event.selectedUrl);
    yield RealEstatsLoaded(realEstats: realEstats);
  }

  ///[Semilar RealEstate ... ]............
  Stream<RealEstatsBlocState> _mapFetchSemilerRealEstate(
      FetchSamilerRealEstate event) async* {
    try {
      yield RealEstatsLoading();
      final List<RealEstate> realEstats =
          await realEstateRepo.fetchSemilerRealStates(event.realEstateId);
      yield RealEstatsLoaded(realEstats: realEstats);
    } catch (e) {
      RealEstatsError(errorMassage: e.toString());
    }
  }

  ///[Last Call RealEstate ... ]............
  Stream<RealEstatsBlocState> _mapFetchLastCallRealEstate(
      FetchLastCallRealEstate event) async* {
    yield RealEstatsLoading();
    final List<RealEstate> realEstats =
        await realEstateRepo.fetchLastCallRealStates(event.userId);
    yield RealEstatsLoaded(realEstats: realEstats);
  }

  ///[Today RealEstate ... ]............
  Stream<RealEstatsBlocState> _mapFetchTodayRealEstate(
      FetchTodayRealEstate event) async* {
    yield RealEstatsLoading();
    final List<RealEstate> realEstats =
        await realEstateRepo.fetchTodayRealStates();
    yield RealEstatsLoaded(realEstats: realEstats);
  }

  ///[Espeacial RealEstate ... ]............
  Stream<RealEstatsBlocState> _mapFetchEspecialRealEstate(
      FetchSpecialRealEstate event) async* {
    yield RealEstatsLoading();
    final List<RealEstate> realEstats =
        await realEstateRepo.fetchEspecialRealStates();
    yield RealEstatsLoaded(realEstats: realEstats);
  }

  ///[Post RealEstate ... ]............
  Stream<RealEstatsBlocState> _mapPostRealEstate(PostRealEstate event) async* {
    try {
      yield RealEstatsLoading();
      await realEstateRepo.postRealEstate(
        realEstate: event.realEstats,
        image: event.image,
        userId: event.userId,
      );
      yield RealEstatsPosted();
    } catch (e) {
      yield RealEstatsError(errorMassage: e.toString());
    }
  }
}
