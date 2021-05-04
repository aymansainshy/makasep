import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:dio/dio.dart';

import '../../repositories/real_estate_repo.dart';
import '../../models/secondryType.dart';
import '../../utils/app_constant.dart';

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
      try {
        yield FetchTypeInProgress();
        final List<SecondryType> type = await realEstateRepo.fetchType();
        yield FetchTypeDone(typeList: type);
      } on DioError catch (e) {
        final errorMassege = dioErrorType(e);
        yield FetchTypeError(errorMassege: errorMassege);
      }
    }
  }
}
