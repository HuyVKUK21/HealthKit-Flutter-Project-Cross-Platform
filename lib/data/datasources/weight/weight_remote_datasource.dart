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
        print('No data found for userId: $userId');
        return null;
      }
    } catch (e) {
      throw Exception("Error getting weight data: $e");
    }
  }

  Future addOrUpdateWeightEntity(WeightEntity weightEntity) async {
    try {
      final weightModel = WeightModel.fromEntity(weightEntity);

      final docSnapshot = await firestore.collection('weights').doc(weightModel.userId).get();

      if (docSnapshot.exists) {
        await firestore.collection('weights').doc(weightModel.userId).update({
          'weightGoal': weightEntity.weightGoal,
          'paceGoal': weightEntity.paceGoal,
          'selectedTimeUnit': weightEntity.selectedTimeUnit,
          'targetWeightDate': weightEntity.targetWeightDate ?? FieldValue.serverTimestamp(),
          'weightsPerWeekGoal': weightEntity.weightsPerWeekGoal,
        });
      } else {

        await firestore.collection('weights').doc(weightModel.userId).set({
          'bmi': weightEntity.bmi,
          'currentWeight': weightEntity.currentWeight,
          'height': weightEntity.height,
          'userId': weightEntity.userId,
          'weightGoal': null,
          'paceGoal': null,
          'selectedTimeUnit': null,
          'targetWeightDate': null,
          'weightsPerWeekGoal': null,
        });
      }
    } catch (e) {
      throw Exception("Error adding or updating weight data: $e");
    }
  }

}

