import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fitnessapp/data/datasources/weight/weight_remote_datasource.dart';
import 'package:fitnessapp/domain/entities/weight_entity.dart';
import 'package:fitnessapp/domain/repositories/weight/weight_repository.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: WeightRepository)
class WeightRepositoryImpl implements WeightRepository {
  final WeightRemoteDatasource weightRemoteDatasource;

  WeightRepositoryImpl(this.weightRemoteDatasource);

  @override
  Future<WeightEntity?> getWeightEntity(String userId) async {
    final weightEntity = await weightRemoteDatasource.getWeightEntity(userId);
    return weightEntity;
  }

  @override
  Future<void> setWeightEntity(WeightEntity weightEntity) async {

    await weightRemoteDatasource.addOrUpdateWeightEntity(weightEntity);
  }

}
