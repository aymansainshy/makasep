part of 'post_realestate_bloc.dart';

abstract class PostRealestateEvent extends Equatable {
  const PostRealestateEvent();

  @override
  List<Object> get props => [];
}

class PostRealEstatee extends PostRealestateEvent {
  final RealEstate realEstats;
  final String userId;
  final File image;

  PostRealEstatee({this.realEstats, this.image, this.userId});
}
