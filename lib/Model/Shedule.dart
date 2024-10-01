class Schedule {
  String scheduleId;
  String caseId;
  String clientId;
  DateTime dateTime;
  String description; // meeting, court hearing, etc.
  String location;
  bool reminder;

  Schedule({
    required this.scheduleId,
    required this.caseId,
    required this.clientId,
    required this.dateTime,
    required this.description,
    required this.location,
    required this.reminder,
  });
}
