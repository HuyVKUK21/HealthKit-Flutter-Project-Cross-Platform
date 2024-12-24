import 'package:fitnessapp/data/models/cigarette_model.dart';

abstract class CigaretteRepository {
  Future<CigaretteModel> getCigaretteByUserId(String id);
  Future<void> insertCigarette(CigaretteModel cigarette);
  Future<bool> isExistCigarette(String idUser);
  Future<void> updateUsageStatusCigarette(String idUser, bool smokingStatusToday);
  Future<bool> checkStatusCigaretteToday(String idUser);
  Future<void> updateEndDate(String id, String newDate);
  Future<void> resetAllUsageStatuses();
}
