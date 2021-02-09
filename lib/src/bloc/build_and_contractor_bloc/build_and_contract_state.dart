part of 'build_and_contract_bloc.dart';

abstract class BuildAndContractState extends Equatable {
  const BuildAndContractState();

  @override
  List<Object> get props => [];
}

class BuildAndContractInitial extends BuildAndContractState {}

class BuildAndContractInProgress extends BuildAndContractState {}

class BuildAndContractDone extends BuildAndContractState {}

class BuildAndContractError extends BuildAndContractState {
  final String errorMassage;

  BuildAndContractError({this.errorMassage});
}
