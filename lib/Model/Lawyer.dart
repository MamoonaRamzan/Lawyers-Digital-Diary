import 'Case.dart';
import 'Client.dart';
import 'Profile.dart';
import 'Shedule.dart';

class Lawyer {
  final String id;
  Profile profile;
  List<Client> clients;
  List<Case> cases;
  List<Schedule> schedule;


  Lawyer({
    required this.id,
    required this.profile,
    required this.clients,
    required this.cases,
    required this.schedule,
  });
}

