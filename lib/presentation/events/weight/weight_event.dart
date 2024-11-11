import 'package:fitnessapp/domain/entities/weight_entity.dart';

abstract class WeightEvent {}

class LoadWeightData extends WeightEvent {
  final String userId;

  LoadWeightData(this.userId);
}

class UpdateWeightData extends WeightEvent {
  final WeightEntity weightEntity;

  UpdateWeightData(this.weightEntity);
}

class CheckWeightDataEvent extends WeightEvent {
  final String userId;

  CheckWeightDataEvent(this.userId);
}


class SaveWeightHeightData extends WeightEvent {
  final double weight;
  final double height;

  SaveWeightHeightData(this.weight, this.height);
}
