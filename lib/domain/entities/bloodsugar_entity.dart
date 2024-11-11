class BloodsugarEntity {
  final String userId;
  final double index;
  final String status;
  final String? statusMeasure;
  final DateTime? dateTime;
  final int? measurementFrequency;


  BloodsugarEntity({
    required this.userId,
    required this.index,
    required this.status,
    this.statusMeasure,
    this.dateTime,
    this.measurementFrequency,
  });

  @override
  String toString() {
    return 'BloodsugarEntity(userId: $userId, systolic: $index, diastolic: $status, measurementFrequency: $measurementFrequency)';
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'index': index,
      'status': status,
      'statusMeasure': statusMeasure,
      'dateTime': dateTime,
      'measurementFrequency': measurementFrequency
    };
  }
}
