import 'package:fitnessapp/data/models/medicine_model.dart';
import 'package:fitnessapp/domain/repositories/medicine/medicine_repository.dart';

class MedicineUseCase {
  late final MedicineReponsitory _medicineReponsitory;

  Future<List<MedicineModel>> getMedicineData(String idUser) async {
    return await _medicineReponsitory.getMedicineData(idUser);
  }

}