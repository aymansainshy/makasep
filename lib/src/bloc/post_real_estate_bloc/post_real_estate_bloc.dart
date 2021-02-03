import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'post_real_estate_event.dart';
part 'post_real_estate_state.dart';

class PostRealEstateBloc extends Bloc<PostRealEstateEvent, PostRealEstateState> {
  PostRealEstateBloc() : super(PostRealEstateInitial());

  @override
  Stream<PostRealEstateState> mapEventToState(
    PostRealEstateEvent event,
  ) async* {
    // TODO: implement mapEventToState
  }
}
