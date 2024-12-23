import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fitnessapp/data/models/cigarette_model.dart';
import 'package:injectable/injectable.dart';
import '../../../domain/repositories/cigarette/cigarette_repository.dart';

@LazySingleton(as: CigaretteRepository)
class CigaretteRepositoryImpl extends CigaretteRepository {
  final CollectionReference _cigaretteCollection = FirebaseFirestore.instance
      .collection('quit_smoking');

  @override
  Future<CigaretteModel> getCigaretteByUserId(String idUser) async {
    QuerySnapshot querySnapshot = await _cigaretteCollection
        .where('user_id', isEqualTo: idUser)
        .get();


    if (querySnapshot.docs.isNotEmpty) {
      DocumentSnapshot doc = querySnapshot.docs.first;
      print('pass');
      return CigaretteModel.fromFirebaseCigarette(
          doc.data() as Map<String, dynamic>, doc.id);
    } else {
      throw Exception('Cigarette not found or already completed');
    }
  }

  @override
  Future<void> insertCigarette(CigaretteModel cigarette) async {
    await _cigaretteCollection.add(cigarette.toFirebaseCigarette());
  }

  @override
  Future<bool> isExistCigarette(String idUser) async {
    final querySnapshot = await _cigaretteCollection
        .where('user_id', isEqualTo: idUser)
        .where('completed_status', isEqualTo: false)
        .limit(1)
        .get();

    return querySnapshot.docs.isNotEmpty;
  }

  @override
  Future<void> updateUsageStatusCigarette(String idUser,
      bool smokingStatusToday) async {
    try {
      QuerySnapshot querySnapshot = await _cigaretteCollection
          .where('user_id', isEqualTo: idUser)
          .where('completed_status', isEqualTo: false)
          .limit(1)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        DocumentSnapshot doc = querySnapshot.docs.first;

        int currentSmokedAmount = (doc['amount_smoked_report'] ?? 0) as int;
        int currentAvoidAmount = (doc['amount_avoid_report'] ?? 0) as int;
        int cigarettesInPack = (doc['cigarettes_in_pack'] ?? 0) as int;
        int amountSmokeDaily = (doc['smoke_daily'] ?? 0) as int;

        await _cigaretteCollection.doc(doc.id).update({
          'smoking_status_today': smokingStatusToday ? smokingStatusToday : !smokingStatusToday,
          'amount_smoked_report': smokingStatusToday ? currentSmokedAmount + 1 : currentSmokedAmount,
          'amount_avoid_report': !smokingStatusToday ? currentAvoidAmount + 1 : currentAvoidAmount,
          'remaining_cigarette': smokingStatusToday ? cigarettesInPack - amountSmokeDaily * (currentSmokedAmount + 1) :
          cigarettesInPack - amountSmokeDaily * (currentSmokedAmount),
          'amount_quit_smoking': !smokingStatusToday ? (currentAvoidAmount + 1) * amountSmokeDaily :
          (currentAvoidAmount) * amountSmokeDaily
        });
      } else {
        throw Exception('error.');
      }
    } catch (e) {}
  }

  @override
  Future<bool> checkStatusCigaretteToday(String idUser) async {
    try {
      QuerySnapshot querySnapshot = await _cigaretteCollection
          .where('user_id', isEqualTo: idUser)
          .where('completed_status', isEqualTo: false)
          .limit(1)
          .get();
      return querySnapshot.docs.isNotEmpty;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<void> updateEndDate(String id, String newDate) async {
    try {
      await _cigaretteCollection.doc(id).update({
        'end_date': newDate,
      });
    } catch (e) {}
  }
}
