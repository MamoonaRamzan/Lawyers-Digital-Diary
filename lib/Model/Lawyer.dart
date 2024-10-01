import 'Case.dart';
import 'Client.dart';
import 'Profile.dart';
import 'Shedule.dart';

class Lawyer {
  Profile profile;
  List<Client> clients;
  List<Case> cases;
  List<Schedule> schedule;

  Lawyer({
    required this.profile,
    required this.clients,
    required this.cases,
    required this.schedule,
  });
}

