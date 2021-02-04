import 'dart:async';

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
    } else if (event is FetchSpecialRealEstate) {
      yield* _mapFetchEspecialRealEstate(event);
    }
  }

  Stream<RealEstatsBlocState> _mapFetchRealEstate(
      FetchRealEstate event) async* {
    yield RealEstatsLoading();
    final List<RealEstate> realEstats = await realEstateRepo.fetchRealStates(
        event.catId, event.filterId, event.selectedUrl);
    yield RealEstatsLoaded(realEstats: realEstats);
  }

  Stream<RealEstatsBlocState> _mapFetchSemilerRealEstate(
      FetchSamilerRealEstate event) async* {
    yield RealEstatsLoading();
    final List<RealEstate> realEstats =
        await realEstateRepo.fetchSemilerRealStates(event.realEstateId);
    yield RealEstatsLoaded(realEstats: realEstats);
  }

  Stream<RealEstatsBlocState> _mapFetchEspecialRealEstate(
      FetchSpecialRealEstate event) async* {
    yield RealEstatsLoading();
    final List<RealEstate> realEstats =
        await realEstateRepo.fetchEspecialRealStates();
    yield RealEstatsLoaded(realEstats: realEstats);
  }
}
