import 'package:cloud_firestore/cloud_firestore.dart';

class MedicineModel {
  final String? id;
  final String medicineName;
  final String dosageTime;
  final String remainingDoses;
  final DateTime? drugStartTime;
  final DateTime? drugEndTime;
  final String drugForm;
  final int frequencyUse;
  final bool? offStatus;
  final bool? usageStatus;
  final String idUser;

  MedicineModel({
    this.id,
    required this.medicineName,
    required this.dosageTime,
    required this.remainingDoses,
    required this.drugForm,
    required this.frequencyUse,
    this.drugStartTime,
    this.drugEndTime,
    this.offStatus,
    this.usageStatus,
    required this.idUser,
  });

  // Chuyển dữ liệu từ Firestore thành đối tượng MedicineModel
  factory MedicineModel.fromFirebaseMedicine(Map<String, dynamic> data, String id) {
    return MedicineModel(
      id: id,
      medicineName: data['medicineName'] ?? '',
      dosageTime: data['dosageTime'] ?? '',
      remainingDoses: data['remainingDoses']?.toString() ?? '0', // Convert to String if needed
      drugForm: data['drugForm'] is Map ? data['drugForm']['name'] ?? '' : '', // Access the 'name' field in the map
      frequencyUse: data['frequencyUse'] ?? 0,
      drugStartTime: (data['drugStartTime'] is Timestamp) ? (data['drugStartTime'] as Timestamp).toDate() : null,
      drugEndTime: (data['drugEndTime'] is Timestamp) ? (data['drugEndTime'] as Timestamp).toDate() : null,
      offStatus: data['offStatus'] ?? false,
      usageStatus: data['usageStatus'] ?? false,
      idUser: data['idUser'] ?? '',
    );
  }
}
