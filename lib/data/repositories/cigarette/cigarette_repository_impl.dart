import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fitnessapp/data/models/cigarette_model.dart';
import '../../../domain/repositories/cigarette/cigarette_repository.dart';

class CigaretteRepositoryImpl extends CigaretteRepository {
  final CollectionReference _cigaretteCollection = FirebaseFirestore.instance.collection('quit_smoking');

  @override
  Future<CigaretteModel> getCigaretteByUserId(String idUser) async {
    QuerySnapshot querySnapshot = await _cigaretteCollection
        .where('user_id', isEqualTo: idUser)
        .get();

    if (querySnapshot.docs.isNotEmpty) {
      DocumentSnapshot doc = querySnapshot.docs.first;
      print('pass');
      return CigaretteModel.fromFirebaseCigarette(doc.data() as Map<String, dynamic>, doc.id);
    } else {
      throw Exception('Cigarette not found or already completed');
    }
  }
}
