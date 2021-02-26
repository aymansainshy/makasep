import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:dio/dio.dart';

import '../../repositories/real_estate_repo.dart';
import '../../models/real_estate_model.dart';
import '../../utils/app_constant.dart';

part 'real_estats_bloc_event.dart';
part 'real_estats_bloc_state.dart';

class RealEstatsBlocBloc
    extends Bloc<RealEstatsBlocEvent, RealEstatsBlocState> {
  final RealEstateRepo realEstateRepo;

  RealEstatsBlocBloc({this.realEstateRepo}) : super(RealEstatsInitial());

  @override
  Stream<RealEstatsBlocState> mapEventToState(
      RealEstatsBlocEvent event) async* {
    if (event is GetRealEstate) {
      yield* _mapFetchRealEstate(event);
    } else if (event is FetchLastCallRealEstate) {
      yield* _mapFetchLastCallRealEstate(event);
    } else if (event is FetchTodayRealEstate) {
      yield* _mapFetchTodayRealEstate(event);
    } else if (event is FetchSpecialRealEstate) {
      yield* _mapFetchEspecialRealEstate(event);
    }
  }

  ///[All RealEstate ... ]............
  Stream<RealEstatsBlocState> _mapFetchRealEstate(GetRealEstate event) async* {
    try {
      yield RealEstatsLoading();
      List<RealEstate> realEstats = await realEstateRepo.fetchRealEstate(
          event.catId, event.filterId, event.selectedUrl);
      if (realEstats != null) {
        yield RealEstatsLoaded(realEstats: realEstats);
      }
    } on DioError catch (e) {
      final errorMassege = dioErrorType(e);
      yield RealEstatsError(errorMassage: errorMassege);
    }
  }

  ///[Last Call RealEstate ... ]............
  Stream<RealEstatsBlocState> _mapFetchLastCallRealEstate(
      FetchLastCallRealEstate event) async* {
    try {
      yield RealEstatsLoading();
      final List<RealEstate> realEstats =
          await realEstateRepo.fetchLastCallRealStates(event.userId);
      yield RealEstatsLoaded(realEstats: realEstats);
    } on DioError catch (e) {
      final errorMassege = dioErrorType(e);
      yield RealEstatsError(errorMassage: errorMassege);
    }
  }

  ///[Today RealEstate ... ]............
  Stream<RealEstatsBlocState> _mapFetchTodayRealEstate(
      FetchTodayRealEstate event) async* {
    try {
      yield RealEstatsLoading();
      final List<RealEstate> realEstats =
          await realEstateRepo.fetchTodayRealStates();
      yield RealEstatsLoaded(realEstats: realEstats);
    } on DioError catch (e) {
      final errorMassege = dioErrorType(e);
      yield RealEstatsError(errorMassage: errorMassege);
    }
  }

  ///[Espeacial RealEstate ... ]............
  Stream<RealEstatsBlocState> _mapFetchEspecialRealEstate(
      FetchSpecialRealEstate event) async* {
    try {
      yield RealEstatsLoading();
      final List<RealEstate> realEstats =
          await realEstateRepo.fetchEspecialRealStates();
      yield RealEstatsLoaded(realEstats: realEstats);
    } on DioError catch (e) {
      final errorMassege = dioErrorType(e);
      yield RealEstatsError(errorMassage: errorMassege);
    }
  }
}
