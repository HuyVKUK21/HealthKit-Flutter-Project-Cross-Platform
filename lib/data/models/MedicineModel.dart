
class Medicine {
  final String medicineName;
  final String dosageTime;
  final String remainingDoses;
  final DateTime? drugStartTime;
  final DateTime? drugEndTime;
  final String drugForm;
  final int frequencyUse;
  final bool? offStatus;
  final bool? usageStatus;

  Medicine({
    required this.medicineName,
    required this.dosageTime,
    required this.remainingDoses,
    required this.drugForm,
    required this.frequencyUse,
    this.drugStartTime,
    this.drugEndTime,
    this.offStatus,
    this.usageStatus,
  });
}
