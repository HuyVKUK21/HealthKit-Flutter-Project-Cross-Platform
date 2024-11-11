import 'package:fitnessapp/domain/entities/bloodsure_entity.dart';
import 'package:fitnessapp/domain/repositories/bloodsure/bloodsure_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetBloodsureUsecase {
  final BloodsureRepository bloodsureRepository;

  GetBloodsureUsecase(this.bloodsureRepository);

  Future<BloodsureEntity?> call(String userId) async {
    return await bloodsureRepository.getBloodsureEntity(userId);
  }
}