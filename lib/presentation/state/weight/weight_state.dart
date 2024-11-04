import 'package:fitnessapp/domain/entities/weight_entity.dart';

abstract class WeightState {}

class WeightInitial extends WeightState {}

class WeightLoading extends WeightState {}

class WeightLoaded extends WeightState {
  final WeightEntity weightEntity;

  WeightLoaded(this.weightEntity);
}

class WeightUpdated extends WeightState {}

class WeightError extends WeightState {
  final String message;

  WeightError(this.message);
}

class WeightDataExists extends WeightState {}
class WeightDataNotFound extends WeightState {}

