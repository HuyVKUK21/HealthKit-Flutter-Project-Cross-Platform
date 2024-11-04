import 'package:fitnessapp/data/models/medicine_model.dart';

abstract class MedicineReponsitory {
  Future<List<MedicineModel>> getMedicineData(String idUser);
}