import 'package:fitnessapp/data/models/meansure_foot_step.dart';

abstract class FootStepRepository {
  Future<FootStepModel?> getFootStepByIdUser(String id);
  Future<void> updateAimByIdUser(String id, int aim);
  Future<void> updateFootStepByIdUser(
      String id, List<Map<String, dynamic>> stepOfDays);
  Future<StepOfDay> updateStepOfDayWhenStopByIdUser(String id, StepOfDay stepOfDay);
}
