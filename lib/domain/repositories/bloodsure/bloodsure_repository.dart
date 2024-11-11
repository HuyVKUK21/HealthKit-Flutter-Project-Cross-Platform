import 'package:fitnessapp/domain/entities/bloodsure_entity.dart';


abstract class BloodsureRepository {
  Future<BloodsureEntity?> getBloodsureEntity(String userId);
  Future<void> setBloodsureEntity(BloodsureEntity bloodsureEntity);
// Future<bool> checkWeightData(String uid);
}
