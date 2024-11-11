import 'package:fitnessapp/domain/entities/bloodsure_entity.dart';
import 'package:fitnessapp/domain/entities/weight_entity.dart';

abstract class BloodsureEvent {}

class LoadBloodsureData extends BloodsureEvent {
  final String userId;

  LoadBloodsureData(this.userId);
}

class UpdateBloodsureData extends BloodsureEvent {
  final BloodsureEntity bloodsureEntity;

  UpdateBloodsureData(this.bloodsureEntity);
}

class CheckWeightDataEvent extends BloodsureEvent {
  final String userId;

  CheckWeightDataEvent(this.userId);
}


class SaveBloodsureData extends BloodsureEvent {
  final int systolic;
  final int diastolic;
  final int heartRate;

  SaveBloodsureData({
    required this.systolic,
    required this.diastolic,
    required this.heartRate,
  });
}
