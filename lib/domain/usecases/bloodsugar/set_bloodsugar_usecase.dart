import 'package:fitnessapp/domain/entities/bloodsugar_entity.dart';
import 'package:fitnessapp/domain/repositories/bloodsugar/bloodsugar_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class SetBloodsugarUsecase {
  final BloodsugarRepository bloodsugarRepository;

  SetBloodsugarUsecase(this.bloodsugarRepository);

  Future<void> call(BloodsugarEntity bloodsugarEntity) async {
    await bloodsugarRepository.setBloodsugarEntity(bloodsugarEntity);
  }
}
