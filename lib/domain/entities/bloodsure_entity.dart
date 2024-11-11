class BloodsureEntity {
  final String userId;
  final int systolic;
  final int diastolic;
  final int heartRate;
  final DateTime? dateTime;
  final int? measurementFrequency;


  BloodsureEntity({
    required this.userId,
    required this.systolic,
    required this.diastolic,
    required this.heartRate,
    this.dateTime,
    this.measurementFrequency,
  });

  @override
  String toString() {
    return 'BloodsureEntity(userId: $userId, systolic: $systolic, diastolic: $diastolic, heartRate: $heartRate, measurementFrequency: $measurementFrequency)';
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'systolic': systolic,
      'diastolic': diastolic,
      'heartRate': heartRate,
      'dateTime': dateTime,
      'measurementFrequency': measurementFrequency
    };
  }
}
