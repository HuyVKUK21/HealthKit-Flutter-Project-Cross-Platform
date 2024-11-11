import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fitnessapp/data/datasources/bloodsugar/bloodsugar_remote_datasource.dart';
import 'package:fitnessapp/data/datasources/bloodsure/bloodsure_remote_datasource.dart';
import 'package:fitnessapp/data/datasources/weight/weight_remote_datasource.dart';
import 'package:fitnessapp/domain/entities/bloodsugar_entity.dart';
import 'package:fitnessapp/domain/entities/bloodsure_entity.dart';
import 'package:fitnessapp/domain/entities/weight_entity.dart';
import 'package:fitnessapp/domain/repositories/bloodsugar/bloodsugar_repository.dart';
import 'package:fitnessapp/domain/repositories/bloodsure/bloodsure_repository.dart';
import 'package:fitnessapp/domain/repositories/weight/weight_repository.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: BloodsugarRepository)
class BloodsugarRepositoryImpl implements BloodsugarRepository {
  final BloodsugarRemoteDatasource bloodsugarRemoteDatasource;

  BloodsugarRepositoryImpl(this.bloodsugarRemoteDatasource);

  @override
  Future<BloodsugarEntity?> getBloodsugarEntity(String userId) async{
    final bloodsugarEntity = await bloodsugarRemoteDatasource.getBloodsugarEntity(userId);
    return bloodsugarEntity;
  }

  @override
  Future<void> setBloodsugarEntity(BloodsugarEntity bloodsugarEntity) async{
    await bloodsugarRemoteDatasource.addOrUpdateBloodsugarEntity(bloodsugarEntity);
  }




}
