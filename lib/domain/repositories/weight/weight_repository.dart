
import 'package:fitnessapp/domain/entities/weight_entity.dart';

abstract class WeightRepository {
  Future<WeightEntity?> getWeightEntity(String userId);
  Future<void> setWeightEntity(WeightEntity weightEntity);
  // Future<bool> checkWeightData(String uid);
}
