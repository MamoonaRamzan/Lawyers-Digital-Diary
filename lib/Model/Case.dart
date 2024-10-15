class Case {
  String caseId;
  String clientId;
  String caseTitle;
  String officeFileNumber;
  String court;
  String courtCaseNumber;
  String judgeName;
  String caseDescription;
  String status; // open, closed, etc.
  String startDate;
  List<String> hearingDates;
  String lawyerNotes;

  Case({
    required this.caseId,
    required this.clientId,
    required this.caseTitle,
    required this.officeFileNumber,
    required this.court,
    required this.courtCaseNumber,
    required this.judgeName,
    required this.caseDescription,
    required this.status,
    required this.startDate,
    required this.hearingDates,
    required this.lawyerNotes,
  });
}
