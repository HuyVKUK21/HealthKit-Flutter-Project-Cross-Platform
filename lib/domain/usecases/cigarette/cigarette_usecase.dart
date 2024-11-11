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
}