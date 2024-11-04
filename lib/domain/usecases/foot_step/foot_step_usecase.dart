import 'package:fitnessapp/data/models/meansure_foot_step.dart';
import 'package:fitnessapp/domain/repositories/foot_step/foot_step_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class FootStepUsecase {
  late final FootStepRepository _footStepReponsitory;

  FootStepUsecase(this._footStepReponsitory);

  Future<FootStepModel?> getFootStepByIdUser(String id) async {
    return await _footStepReponsitory.getFootStepByIdUser(id);
  }

  Future<void> updateAimByIdUser(String id, int aim) async {
    return await _footStepReponsitory.updateAimByIdUser(id, aim);
  }

  Future<void> updateFootStepByIdUser(
      String id, List<Map<String, dynamic>> stepOfDays) async {
    return await _footStepReponsitory.updateFootStepByIdUser(id, stepOfDays);
  }

  Future<StepOfDay> updateStepOfDayWhenStopByIdUser(
      String id, StepOfDay stepOfDay) async {
    return await _footStepReponsitory.updateStepOfDayWhenStopByIdUser(
        id, stepOfDay);
  }
}
