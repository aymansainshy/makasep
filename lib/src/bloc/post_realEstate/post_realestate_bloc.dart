import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:dio/dio.dart';

import '../../models/real_estate_model.dart';
import '../../utils/app_constant.dart';
import '../../repositories/real_estate_repo.dart';

part 'post_realestate_event.dart';
part 'post_realestate_state.dart';

class PostRealestateBloc
    extends Bloc<PostRealestateEvent, PostRealestateState> {
  final RealEstateRepo realEstateRepo;
  PostRealestateBloc({this.realEstateRepo}) : super(PostRealestateInitial());

  @override
  Stream<PostRealestateState> mapEventToState(
    PostRealestateEvent event,
  ) async* {
    if (event is PostRealEstatee) {
      yield* _mapPostRealEstate(event);
    }
  }

  ///[Post RealEstate ... ]............
  Stream<PostRealestateState> _mapPostRealEstate(PostRealEstatee event) async* {
    try {
      yield PostRealestateInprogress();
      await realEstateRepo.postRealEstate(
        realEstate: event.realEstats,
        image: event.image,
        userId: event.userId,
      );
      yield PostRealestateDone();
    } on DioError catch (e) {
      final errorMassege = dioErrorType(e);
      yield PostRealestateError(errorMassage: errorMassege);
    }
  }
}
