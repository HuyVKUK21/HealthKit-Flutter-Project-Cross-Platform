import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fitnessapp/data/models/bloodsure_model.dart';
import 'package:fitnessapp/data/models/weight_model.dart';
import 'package:fitnessapp/domain/entities/bloodsure_entity.dart';
import 'package:fitnessapp/domain/entities/weight_entity.dart';
import 'package:injectable/injectable.dart';

@injectable
class BloodsureRemoteDatasource {
  final FirebaseFirestore firestore;

  BloodsureRemoteDatasource(this.firestore);
  //
  Future<BloodsureEntity?> getBloodsureEntity(String userId) async {
    try {
      DocumentSnapshot snapshot = await firestore.collection('bloodsure').doc(userId).get();

      if (snapshot.exists) {
        BloodsureModel bloodsureModel = BloodsureModel.fromJson(snapshot.data() as Map<String, dynamic>);
        return bloodsureModel.toEntity();
      } else {
        return null;
      }
    } catch (e) {
      throw Exception("Error getting bloodsure data: $e");
    }
  }

  Future<void> addOrUpdateBloodsureEntity(BloodsureEntity bloodsureEntity) async {
    try {
      final bloodsureModel = BloodsureModel.fromEntity(bloodsureEntity);
      await firestore.collection('bloodsure').doc(bloodsureModel.userId).set(bloodsureModel.toJson());
    } catch (e) {
      throw Exception("Error updating bloodsure data: $e");
    }
  }

}

