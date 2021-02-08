part of 'build_and_contract_bloc.dart';

abstract class BuildAndContractEvent extends Equatable {
  const BuildAndContractEvent();

  @override
  List<Object> get props => [];
}

class PostBuildAndContract extends BuildAndContractEvent {
  final String userId;
  final String phoneNumber;
  final String city;
  final String description;
  final String buildingTypeId;

  PostBuildAndContract({
    this.userId,
    this.phoneNumber,
    this.city,
    this.description,
    this.buildingTypeId,
  });
}
