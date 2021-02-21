import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:makasep/src/repositories/real_estate_repo.dart';

import '../../models/secondryType.dart';

part 'fetch_type_event.dart';
part 'fetch_type_state.dart';

class FetchTypeBloc extends Bloc<FetchTypeEvent, FetchTypeState> {
  final RealEstateRepo realEstateRepo;
  FetchTypeBloc({this.realEstateRepo}) : super(FetchTypeInitial());

  @override
  Stream<FetchTypeState> mapEventToState(
    FetchTypeEvent event,
  ) async* {
    if (event is FetchTypeEvent) {
      yield FetchTypeInProgress();
      final List<SecondryType> type = await realEstateRepo.fetchType();
      yield FetchTypeDone(typeList: type);
    }
  }
}
