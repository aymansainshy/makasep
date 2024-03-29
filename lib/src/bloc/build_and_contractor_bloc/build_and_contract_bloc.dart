import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:dio/dio.dart';

import '../../repositories/real_estate_repo.dart';
import '../../utils/app_constant.dart';

part 'build_and_contract_event.dart';
part 'build_and_contract_state.dart';

class BuildAndContractBloc
    extends Bloc<BuildAndContractEvent, BuildAndContractState> {
  final RealEstateRepo realEstateRepo;
  BuildAndContractBloc({this.realEstateRepo})
      : super(BuildAndContractInitial());

  @override
  Stream<BuildAndContractState> mapEventToState(
      BuildAndContractEvent event) async* {
    if (event is PostBuildAndContract) {
      yield* _mapPostBuildingAndContract(event);
    }
  }

  ///[All RealEstate ... ]............
  Stream<BuildAndContractState> _mapPostBuildingAndContract(
      PostBuildAndContract event) async* {
    try {
      yield BuildAndContractInProgress();
      await realEstateRepo.postBuildingAndContract(
        buildingTypeId: event.buildingTypeId,
        city: event.city,
        description: event.description,
        phoneNumber: event.phoneNumber,
        usetId: event.userId,
      );
      yield BuildAndContractDone();
    } on DioError catch (e) {
      final errorMassege = dioErrorType(e);
      yield BuildAndContractError(errorMassage: errorMassege);
    }
  }
}
