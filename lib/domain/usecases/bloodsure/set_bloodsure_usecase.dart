import 'package:fitnessapp/domain/entities/bloodsure_entity.dart';
import 'package:fitnessapp/domain/entities/weight_entity.dart';
import 'package:fitnessapp/domain/repositories/bloodsure/bloodsure_repository.dart';
import 'package:fitnessapp/domain/repositories/weight/weight_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class SetBloodsureUsecase {
  final BloodsureRepository bloodsureRepository;

  SetBloodsureUsecase(this.bloodsureRepository);

  Future<void> call(BloodsureEntity bloodsureEntity) async {
    await bloodsureRepository.setBloodsureEntity(bloodsureEntity);
  }
}
