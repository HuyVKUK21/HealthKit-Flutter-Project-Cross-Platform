import 'package:fitnessapp/domain/entities/weight_entity.dart';
import 'package:fitnessapp/domain/repositories/weight/weight_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetWeightUsecase {
  final WeightRepository weightRepository;

  GetWeightUsecase(this.weightRepository);

  Future<WeightEntity?> call(String userId) async {
    return await weightRepository.getWeightEntity(userId);
  }
}
