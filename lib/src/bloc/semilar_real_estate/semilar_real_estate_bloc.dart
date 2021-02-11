import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../models/real_estate_model.dart';
import '../../repositories/real_estate_repo.dart';

part 'semilar_real_estate_event.dart';
part 'semilar_real_estate_state.dart';

class SemilarRealEstateBloc
    extends Bloc<SemilarRealEstateEvent, SemilarRealEstateState> {
  final RealEstateRepo realEstateRepo;
  SemilarRealEstateBloc({this.realEstateRepo})
      : super(SemilarRealEstateInitial());

  @override
  Stream<SemilarRealEstateState> mapEventToState(
      SemilarRealEstateEvent event) async* {
    if (event is FetchSemilarRealEstate) {
      yield* _mapFetchSemilerRealEstate(event);
    }
  }

  ///[Semilar RealEstate ... ]............
  Stream<SemilarRealEstateState> _mapFetchSemilerRealEstate(
      FetchSemilarRealEstate event) async* {
    try {
      yield SemilarRealEstateInProgress();
      final List<RealEstate> realEstats =
          await realEstateRepo.fetchSemilerRealStates(event.realEstateId);
      yield SemilarRealEstateLoadingDone(realEstates: realEstats);
    } catch (e) {
      SemilarRealEstateError(errorMassage: e.toString());
    }
  }
}
