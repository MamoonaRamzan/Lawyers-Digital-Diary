class Case {
  String caseId;
  String clientId;
  String caseTitle;
  String caseDescription;
  String status; // open, closed, etc.
  DateTime startDate;
  List<DateTime> hearingDates;
  String lawyerNotes;

  Case({
    required this.caseId,
    required this.clientId,
    required this.caseTitle,
    required this.caseDescription,
    required this.status,
    required this.startDate,
    required this.hearingDates,
    required this.lawyerNotes,
  });
}
