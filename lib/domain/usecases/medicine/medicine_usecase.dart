import 'package:fitnessapp/data/models/medicine_model.dart';
import 'package:fitnessapp/domain/repositories/medicine/medicine_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class MedicineUseCase {
  late final MedicineRepository _medicineReponsitory;

  MedicineUseCase(this._medicineReponsitory);

  Future<List<MedicineModel>> getMedicineData(String idUser) async {
    return await _medicineReponsitory.getMedicineData(idUser);
  }

  Future<MedicineModel> getMedicineById(String? id) async {
    return await _medicineReponsitory.getMedicineById(id!);
  }

  Future<void> updateOffStatusMedicine(String? id, bool? offStatus) async {
    await _medicineReponsitory.updateOffStatusMedicine(id!, offStatus!);
  }

  Future<void> updateUsageStatusMedicine(String? id, bool? used) async {
    await _medicineReponsitory.updateUsageStatusMedicine(id!, used!);
  }

  Future<void> deleteMedicine(String? id) async {
    await _medicineReponsitory.deleteMedicine(id!);
  }

  Future<void> resetAllUsageStatuses() async {
    await _medicineReponsitory.resetAllUsageStatuses();
  }

  Future<void> insertMedicine(MedicineModel medicine) async {
    return await _medicineReponsitory.insertMedicine(medicine);
  }

  Future<bool> isExistMedicine(String idUser) async {
    return await _medicineReponsitory.isExistMedicine(idUser);
  }

}