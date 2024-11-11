import 'package:fitnessapp/data/models/cigarette_model.dart';

abstract class CigaretteRepository {
  Future<CigaretteModel> getCigaretteByUserId(String id);
  Future<void> insertCigarette(CigaretteModel cigarette);
  Future<bool> isExistCigarette(String idUser);
}
