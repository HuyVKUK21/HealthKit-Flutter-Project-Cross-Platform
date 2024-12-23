import 'package:injectable/injectable.dart';

import '../../../data/models/cigarette_model.dart';
import '../../repositories/cigarette/cigarette_repository.dart';

@injectable
class CigaretteUseCase {
  late final CigaretteRepository _cigaretteRepository;

  CigaretteUseCase(this._cigaretteRepository);

  Future<CigaretteModel> getCigaretteByUserId(String id) async {
    return await _cigaretteRepository.getCigaretteByUserId(id);
  }

  Future<void> insertCigarette(CigaretteModel cigarette) async {
    return await _cigaretteRepository.insertCigarette(cigarette);
  }

  Future<bool> isExistCigarette(String idUser) async {
    return await _cigaretteRepository.isExistCigarette(idUser);
  }

  Future<void> updateUsageStatusCigarette(String idUser, bool smokingStatusToday) async {
    return await _cigaretteRepository.updateUsageStatusCigarette(idUser, smokingStatusToday);
  }

  Future<bool> checkStatusCigaretteToday(String idUser) async {
    return await _cigaretteRepository.checkStatusCigaretteToday(idUser);
  }

  Future<void> updateEndDate(String id, String newDate) async {
    return await _cigaretteRepository.updateEndDate(id, newDate);
  }

}