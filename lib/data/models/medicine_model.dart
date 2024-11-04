
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

  // Chuyển dữ liệu thành Map
  Map<String, dynamic> toMap() {
    return {
      'medicineName': medicineName,
      'dosageTime': dosageTime,
      'remainingDoses': remainingDoses,
      'drugForm': drugForm,
      'frequencyUse': frequencyUse,
      'drugStartTime': drugStartTime,
      'drugEndTime': drugEndTime,
      'offStatus': offStatus,
      'usageStatus': usageStatus,
      'idUser': idUser,
    };
  }

  // Tạo đối tượng User từ Firestore document snapshot
  factory MedicineModel.fromFirebaseMedicine(Map<String, dynamic> data, String id) {
    return MedicineModel(
      id: id,
      medicineName: data['medicineName'] ?? '',
      dosageTime: data['dosageTime'] ?? '',
      remainingDoses: data['remainingDoses'] ?? '',
      drugForm: data['drugForm'] ?? '',
      frequencyUse: data['frequencyUse'] ?? '',
      drugStartTime: data['drugStartTime'] ?? '',
      drugEndTime: data['drugEndTime'] ?? '',
      offStatus: data['offStatus'] ?? '',
      usageStatus: data['usageStatus'] ?? '',
      idUser: data['idUser'] ?? '',
    );
  }

}
