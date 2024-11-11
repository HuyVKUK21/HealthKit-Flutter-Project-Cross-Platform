class CigaretteModel {
  final String? id;
  final String titleTarget;
  final bool smokingStatusToday;
  final bool? completedStatus;
  final int price ;
  final int cigaretteInPack;
  final int remainingCigarette;
  final String startDate;
  final String endDate;
  final int smokeDaily;
  final int? amountAvoidedReport;
  final int? amountSmokedReport;
  final int amountDayTarget;
  final int amountQuitSmoking;
  final int amountDayQuit;
  final String idUser;

  CigaretteModel({
    this.id,
    required this.titleTarget,
    required this.smokingStatusToday,
    this.completedStatus,
    required this.price,
    required this.cigaretteInPack,
    required this.remainingCigarette,
    required this.startDate,
    required this.endDate,
    required this.smokeDaily,
    this.amountAvoidedReport,
    this.amountSmokedReport,
    required this.amountDayTarget,
    required this.amountQuitSmoking,
    required this.amountDayQuit,
    required this.idUser,
  });

  factory CigaretteModel.fromFirebaseCigarette(Map<String, dynamic> data, String id) {
    return CigaretteModel(
      id: id,
      titleTarget: data['title_target'] ?? '',
      smokingStatusToday: data['smoking_status_today'] ?? false,
      completedStatus: data['completed_status'] is bool
          ? data['completed_status']
          : (data['completed_status'] == 1),
      price: data['price'] ?? 0,
      cigaretteInPack: data['cigarettes_in_pack'] ?? 0,
      remainingCigarette: data['remaining_cigarette'] ?? 0,
      startDate: data['start_date'] ?? '',
      endDate: data['end_date'] ?? '',
      smokeDaily: data['smoke_daily'] ?? 0,
      amountAvoidedReport: data['amount_avoid_report'] ?? 0,
      amountSmokedReport: data['amount_smoked_report'] ?? 0,
      amountDayTarget: data['amount_day_target'] ?? 0,
      amountQuitSmoking: data['amount_quit_smoking'] ?? 0,
      amountDayQuit: data['amount_day_quit'] ?? 0,
      idUser: data['user_id'] ?? '',
    );
  }

}
