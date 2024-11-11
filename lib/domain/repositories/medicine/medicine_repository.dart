import 'package:fitnessapp/data/models/medicine_model.dart';

abstract class MedicineRepository {
  Future<List<MedicineModel>> getMedicineData(String idUser);
  Future<MedicineModel> getMedicineById(String id);
  Future<void> updateOffStatusMedicine(String id, bool offStatus);
  Future<void> updateUsageStatusMedicine(String id, bool used);
  Future<void> deleteMedicine(String id);
  Future<void> resetAllUsageStatuses();
  Future<bool> isExistMedicine(String idUser);
}