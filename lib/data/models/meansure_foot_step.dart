class Result {
  final StepOfDay stepOfDay;
  final bool exists;

  Result({required this.stepOfDay, required this.exists});
}

class FootStepModel {
  final String idUser;
  final int aim;
  final List<StepOfDay> stepOfDay;

  FootStepModel({
    required this.idUser,
    required this.aim,
    required this.stepOfDay,
  });

  FootStepModel copyWith({int? newAim}) {
    return FootStepModel(
      idUser: idUser,
      aim: newAim ?? aim, // Nếu newAim là null, giữ nguyên aim hiện tại
      stepOfDay: stepOfDay,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'idUser': idUser,
      'aim': aim,
      'stepOfDay': stepOfDay.map((step) => step.toMap()).toList(),
    };
  }

  Result findStepOfToday() {
    DateTime today = DateTime.now();
    final stringDate = '${today.day}/${today.month}/${today.year}';

    for (var step in stepOfDay) {
      // print('${step.date} == ${stringDate} ${today == step.date}');
      if (step.date == stringDate) {
        return Result(stepOfDay: step, exists: true);
      }
    }

    final newStepOfDay = StepOfDay(date: stringDate, step: 0);
    return Result(stepOfDay: newStepOfDay, exists: false);
  }
}

class StepOfDay {
  final String date;
  final int step;

  StepOfDay({
    required this.date,
    required this.step,
  });

  StepOfDay copyWith({int? step}) {
    return StepOfDay(
      date: date,
      step: step ?? 0,
    );
  }

  int getStep() {
    return step;
  }

  Map<String, dynamic> toMap() {
    return {
      'date': date,
      'step': step,
    };
  }
}
