import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fitnessapp/data/datasources/bloodsure/bloodsure_remote_datasource.dart';
import 'package:fitnessapp/data/datasources/weight/weight_remote_datasource.dart';
import 'package:fitnessapp/domain/entities/bloodsure_entity.dart';
import 'package:fitnessapp/domain/entities/weight_entity.dart';
import 'package:fitnessapp/domain/repositories/bloodsure/bloodsure_repository.dart';
import 'package:fitnessapp/domain/repositories/weight/weight_repository.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: BloodsureRepository)
class BloodsureRepositoryImpl implements BloodsureRepository {
  final BloodsureRemoteDatasource bloodsureRemoteDatasource;

  BloodsureRepositoryImpl(this.bloodsureRemoteDatasource);



  @override
  Future<BloodsureEntity?> getBloodsureEntity(String userId) {
    // TODO: implement getBloodsureEntity
    throw UnimplementedError();
  }

  @override
  Future<void> setBloodsureEntity(BloodsureEntity bloodsureEntity) async{
    await bloodsureRemoteDatasource.addOrUpdateBloodsureEntity(bloodsureEntity);
  }

}
