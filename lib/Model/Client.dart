import 'Case.dart';
class Client {
  String clientId;
  String name;
  String email;
  String phone;
  String address;
  DateTime onboardDate;
  List<Case> caseList;

  Client({
    required this.clientId,
    required this.name,
    required this.email,
    required this.phone,
    required this.address,
    required this.onboardDate,
    required this.caseList,
  });
}
