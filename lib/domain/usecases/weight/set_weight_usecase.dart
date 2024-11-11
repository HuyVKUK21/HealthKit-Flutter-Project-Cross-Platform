import 'package:fitnessapp/domain/entities/weight_entity.dart';
import 'package:fitnessapp/domain/repositories/weight/weight_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class SetWeightUsecase {
  final WeightRepository repository;

  SetWeightUsecase(this.repository);

  Future<void> call(WeightEntity weightEntity) async {
    await repository.setWeightEntity(weightEntity);
  }
}
