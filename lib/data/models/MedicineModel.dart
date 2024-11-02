class Medicine {
  final String medicineName;
  final String dosageTime;
  final String remainingDoses;
  final bool? usageStatus;

  Medicine({
    required this.medicineName,
    required this.dosageTime,
    required this.remainingDoses,
    this.usageStatus,
  });
}
