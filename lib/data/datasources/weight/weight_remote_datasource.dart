import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fitnessapp/data/models/weight_model.dart';
import 'package:fitnessapp/domain/entities/weight_entity.dart';
import 'package:injectable/injectable.dart';

@injectable
class WeightRemoteDatasource {
  final FirebaseFirestore firestore;

  WeightRemoteDatasource(this.firestore);

  Future<WeightEntity?> getWeightEntity(String userId) async {
    try {
      DocumentSnapshot snapshot = await firestore.collection('weights').doc(userId).get();

      if (snapshot.exists) {
        WeightModel weightModel = WeightModel.fromJson(snapshot.data() as Map<String, dynamic>);
        return weightModel.toEntity();
      } else {
        return null;
      }
    } catch (e) {
      throw Exception("Error getting weight data: $e");
    }
  }

  Future<void> addOrUpdateWeightEntity(WeightEntity weightEntity) async {
    try {
      final weightModel = WeightModel.fromEntity(weightEntity);
      await firestore.collection('weights').doc(weightModel.userId).set(weightModel.toJson());
    } catch (e) {
      throw Exception("Error updating weight data: $e");
    }
  }

}

