import 'package:fitnessapp/domain/entities/bloodsugar_entity.dart';
import 'package:fitnessapp/domain/entities/bloodsure_entity.dart';


abstract class BloodsugarRepository {
  Future<BloodsugarEntity?> getBloodsugarEntity(String userId);
  Future<void> setBloodsugarEntity(BloodsugarEntity bloodsugarEntity);
}
