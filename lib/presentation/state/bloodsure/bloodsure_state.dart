import 'package:fitnessapp/domain/entities/bloodsure_entity.dart';


abstract class BloodsureState {}

class BloodsureInitial extends BloodsureState {}

class BloodsureLoading extends BloodsureState {}

class BloodsureLoaded extends BloodsureState {
  final BloodsureEntity bloodsureEntity;

  BloodsureLoaded(this.bloodsureEntity);
}

class BloodsureUpdated extends BloodsureState {}

class BloodsureError extends BloodsureState {
  final String message;

  BloodsureError(this.message);
}

class BloodsureDataExists extends BloodsureState {}
class BloodsureDataNotFound extends BloodsureState {}

