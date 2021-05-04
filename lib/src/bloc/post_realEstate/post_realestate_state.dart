part of 'post_realestate_bloc.dart';

abstract class PostRealestateState extends Equatable {
  const PostRealestateState();

  @override
  List<Object> get props => [];
}

class PostRealestateInitial extends PostRealestateState {}

class PostRealestateInprogress extends PostRealestateState {}

class PostRealestateDone extends PostRealestateState {}

class PostRealestateError extends PostRealestateState {
  final String errorMassage;

  PostRealestateError({this.errorMassage});
}
