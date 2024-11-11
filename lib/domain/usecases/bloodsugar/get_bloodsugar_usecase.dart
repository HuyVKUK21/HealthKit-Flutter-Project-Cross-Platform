import 'package:fitnessapp/domain/entities/bloodsugar_entity.dart';
import 'package:fitnessapp/domain/entities/bloodsure_entity.dart';
import 'package:fitnessapp/domain/repositories/bloodsugar/bloodsugar_repository.dart';
import 'package:fitnessapp/domain/repositories/bloodsure/bloodsure_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetBloodsugarUsecase {
  final BloodsugarRepository bloodsugarRepository;

  GetBloodsugarUsecase(this.bloodsugarRepository);

  Future<BloodsugarEntity?> call(String userId) async {
    return await bloodsugarRepository.getBloodsugarEntity(userId);
  }
}