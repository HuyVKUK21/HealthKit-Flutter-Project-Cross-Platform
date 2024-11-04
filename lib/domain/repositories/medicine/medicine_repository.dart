import 'package:fitnessapp/data/models/medicine_model.dart';

abstract class MedicineRepository {
  Future<List<MedicineModel>> getMedicineData(String idUser);
  Future<MedicineModel> getMedicineById(String id);
}