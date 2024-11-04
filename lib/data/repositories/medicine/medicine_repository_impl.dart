import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fitnessapp/data/models/medicine_model.dart';
import 'package:fitnessapp/domain/repositories/medicine/medicine_repository.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: MedicineReponsitory)
class MedicineRepositoryImpl extends MedicineReponsitory {

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
}