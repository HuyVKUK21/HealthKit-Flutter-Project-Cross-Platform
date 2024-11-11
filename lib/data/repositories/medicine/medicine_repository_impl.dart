import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fitnessapp/data/models/medicine_model.dart';
import 'package:fitnessapp/domain/repositories/medicine/medicine_repository.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: MedicineRepository)
class MedicineRepositoryImpl extends MedicineRepository {

  final CollectionReference _medicinesCollection = FirebaseFirestore.instance.collection('medicines');

  @override
  Future<List<MedicineModel>> getMedicineData(String idUser) async {
    QuerySnapshot querySnapshot = await _medicinesCollection.get();
    return querySnapshot
        .docs
        .where((doc) => doc['idUser'] == idUser)
        .map((doc) {
      return MedicineModel.fromFirebaseMedicine(doc.data() as Map<String, dynamic>, doc.id);
    }).toList();
  }

  @override
  Future<MedicineModel> getMedicineById(String id) async {
    DocumentSnapshot doc = await _medicinesCollection.doc(id).get();
    if (doc.exists) {
      return MedicineModel.fromFirebaseMedicine(doc.data() as Map<String, dynamic>, doc.id);
    } else {
      throw Exception('Medicine not found');
    }
  }

  @override
  Future<void> updateOffStatusMedicine(String id, bool offStatus) async {
    try {
      await _medicinesCollection.doc(id).update({
        'offStatus': !offStatus,
      });
    } catch (e) {}
  }

  @override
  Future<void> updateUsageStatusMedicine(String id, bool used) async {
    try {
      DocumentSnapshot documentSnapshot = await _medicinesCollection.doc(id).get();
      if (documentSnapshot.exists) {
        int currentRemainingDoses = documentSnapshot['remainingDoses'];
        await _medicinesCollection.doc(id).update({
          'usageStatus': !used,
          'remainingDoses': used ? currentRemainingDoses + 1 : currentRemainingDoses - 1,
        });
      }
    } catch (e) {}
  }

  @override
  Future<void> deleteMedicine(String id) async {
    try {
      await _medicinesCollection.doc(id).update({
        'isDeleted': true,
      });
    } catch (e) {}
  }

  @override
  Future<void> resetAllUsageStatuses() async {
    try {
      QuerySnapshot snapshot = await _medicinesCollection
          .where('usageStatus', isEqualTo: true)
          .get();
      for (var doc in snapshot.docs) {
        await doc.reference.update({'usageStatus': false});
      }
    } catch (e) {
      print('Error resetting usage statuses: $e');
    }
  }

  @override
  Future<bool> isExistMedicine(String idUser) async {
    final querySnapshot = await _medicinesCollection
        .where('user_id', isEqualTo: idUser)
        .where('offStatus', isEqualTo: false)
        .limit(1)
        .get();

    return querySnapshot.docs.isNotEmpty;
  }


}