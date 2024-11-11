import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fitnessapp/data/models/bloodsugar_model.dart';
import 'package:fitnessapp/data/models/bloodsure_model.dart';
import 'package:fitnessapp/data/models/weight_model.dart';
import 'package:fitnessapp/domain/entities/bloodsugar_entity.dart';
import 'package:fitnessapp/domain/entities/bloodsure_entity.dart';
import 'package:fitnessapp/domain/entities/weight_entity.dart';
import 'package:injectable/injectable.dart';

@injectable
class BloodsugarRemoteDatasource {
  final FirebaseFirestore firestore;

  BloodsugarRemoteDatasource(this.firestore);

  Future<BloodsugarEntity?> getBloodsugarEntity(String userId) async {
    try {
      DocumentSnapshot snapshot = await firestore.collection('bloodsugar').doc(userId).get();

      if (snapshot.exists) {
        BloodsugarModel bloodsugarModel = BloodsugarModel.fromJson(snapshot.data() as Map<String, dynamic>);
        return bloodsugarModel.toEntity();
      } else {
        return null;
      }
    } catch (e) {
      throw Exception("Error getting bloodsugar data: $e");
    }
  }

  Future<void> addOrUpdateBloodsugarEntity(BloodsugarEntity bloodsugarEntity) async {
    try {
      final bloodsureModel = BloodsugarModel.fromEntity(bloodsugarEntity);
      await firestore.collection('bloodsugar').doc(bloodsureModel.userId).set(bloodsureModel.toJson());
    } catch (e) {
      throw Exception("Error updating bloodsugar data: $e");
    }
  }

}

