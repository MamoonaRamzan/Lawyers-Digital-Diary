import 'package:cloud_firestore/cloud_firestore.dart';

import '../Model/Case.dart';
import '../Model/Client.dart';
import '../Model/Lawyer.dart';
import '../Model/Package.dart';
import '../Model/Profile.dart';
import '../Model/Shedule.dart';
import '../Model/UserFeedBack.dart';

class FetchData{

  Future<List<Lawyer>> fetchLawyers() async {
    List<Lawyer> lawyersList = [];

    // Fetch lawyers collection
    QuerySnapshot lawyersSnapshot = await FirebaseFirestore.instance
        .collection('Lawyer')
        .get();

    for (var lawyerDoc in lawyersSnapshot.docs) {
      // Fetch subcollections
      var profile = await fetchProfile(lawyerDoc.id);
      var clients = await fetchClients(lawyerDoc.id);
      var cases = await fetchCases(lawyerDoc.id);
      var schedule = await fetchSchedule(lawyerDoc.id);

      // Create Lawyer object
      Lawyer lawyer = Lawyer(
        profile: profile,
        clients: clients,
        cases: cases,
        schedule: schedule,
      );

      lawyersList.add(lawyer);
    }

    return lawyersList;
  }
  Future<Profile> fetchProfile(String lawyerId) async {
    DocumentSnapshot profileDoc = await FirebaseFirestore.instance
        .collection('Lawyer')
        .doc(lawyerId)
        .collection('Profile')
        .doc('LSZgXc185fkM7o5S11iY')
        .get(); // To inspect the document contents


    return Profile(
      name: profileDoc['name'],
      email: profileDoc['email'],
      phone: profileDoc['phone'],
      password: profileDoc['password'],
      firmName: profileDoc['firmName'],
      ChamberAddress: profileDoc['ChamberAddress'],
      specialization: profileDoc['specialization'],
      courtAffiliation: profileDoc['courtAffiliation'],
      package: profileDoc['package'],
    );
  }
  Future<List<Client>> fetchClients(String lawyerId) async {
    List<Client> clientsList = [];

    QuerySnapshot clientsSnapshot = await FirebaseFirestore.instance
        .collection('Lawyer')
        .doc(lawyerId)
        .collection('clients')
        .get();

    for (var clientDoc in clientsSnapshot.docs) {
      // Fetch case references from client
      List<Case> caseList = await fetchCaseList(clientDoc);

      Client client = Client(
        clientId: clientDoc['clientId'],
        name: clientDoc['name'],
        email: clientDoc['email'],
        phone: clientDoc['phone'],
        address: clientDoc['address'],
        onboardDate: clientDoc['onboardDate'],
        clientType: clientDoc['clientType'],
        caseList: caseList,
      );

      clientsList.add(client);
    }

    return clientsList;
  }

  Future<List<Case>> fetchCaseList(QueryDocumentSnapshot clientDoc) async {
    List<Case> caseList = [];
    List<DocumentReference> caseRefs = List<DocumentReference>.from(clientDoc['caseList']);

    for (var caseRef in caseRefs) {
      DocumentSnapshot caseDoc = await caseRef.get();

      caseList.add(
        Case(
          caseId: caseDoc['caseId'],
          clientId: caseDoc['clientId'],
          caseTitle: caseDoc['caseTitle'],
          officeFileNumber: caseDoc['officeFileNumber'],
          court: caseDoc['court'],
          courtCaseNumber: caseDoc['courtCaseNumber'],
          judgeName: caseDoc['judgeName'],
          caseDescription: caseDoc['caseDescription'],
          status: caseDoc['status'],
          startDate: caseDoc['startDate'],
          hearingDates: List<String>.from(caseDoc['hearingDates']),
          lawyerNotes: caseDoc['lawyerNotes'],
        ),
      );
    }

    return caseList;
  }
  Future<List<Case>> fetchCases(String lawyerId) async {
    List<Case> casesList = [];

    QuerySnapshot casesSnapshot = await FirebaseFirestore.instance
        .collection('Lawyer')
        .doc(lawyerId)
        .collection('cases')
        .get();

    for (var caseDoc in casesSnapshot.docs) {
      casesList.add(
        Case(
          caseId: caseDoc['caseId'],
          clientId: caseDoc['clientId'],
          caseTitle: caseDoc['caseTitle'],
          officeFileNumber: caseDoc['officeFileNumber'],
          court: caseDoc['court'],
          courtCaseNumber: caseDoc['courtCaseNumber'],
          judgeName: caseDoc['judgeName'],
          caseDescription: caseDoc['caseDescription'],
          status: caseDoc['status'],
          startDate: caseDoc['startDate'],
          hearingDates: List<String>.from(caseDoc['hearingDates']),
          lawyerNotes: caseDoc['lawyerNotes'],
        ),
      );
    }

    return casesList;
  }
  Future<List<Schedule>> fetchSchedule(String lawyerId) async {
    List<Schedule> scheduleList = [];

    // Fetch schedule collection for a lawyer
    QuerySnapshot scheduleSnapshot = await FirebaseFirestore.instance
        .collection('Lawyer')
        .doc(lawyerId)
        .collection('shedule')
        .get();

    // Debugging: print the number of schedule docs fetched
    print('Number of schedule documents: ${scheduleSnapshot.docs.length}');

    for (var scheduleDoc in scheduleSnapshot.docs) {
      if (scheduleDoc.exists) {
        // Check if the document contains the necessary fields
        Map<String, dynamic>? data = scheduleDoc.data() as Map<String, dynamic>?;
        if (data != null &&
            data.containsKey('scheduleId') &&
            data.containsKey('caseId') &&
            data.containsKey('clientId') &&
            data.containsKey('dateTime') &&
            data.containsKey('description') &&
            data.containsKey('location') &&
            data.containsKey('reminder')) {

          scheduleList.add(
            Schedule(
              scheduleId: data['scheduleId'],
              caseId: data['caseId'],
              clientId: data['clientId'],
              dateTime: data['dateTime'],
              description: data['description'],
              location: data['location'],
              reminder: data['reminder'],
            ),
          );
        } else {
          print('Missing required fields in schedule document: ${scheduleDoc.id}');
        }
      } else {
        print('Schedule document does not exist: ${scheduleDoc.id}');
      }
    }

    return scheduleList;
  }
  Future<List<Package>> fetchPackages() async {
    List<Package> packageList = [];

    // Fetch the 'package' collection
    QuerySnapshot packageSnapshot = await FirebaseFirestore.instance
        .collection('package')
        .get();

    // Debugging: print the number of package docs fetched
    print('Number of package documents: ${packageSnapshot.docs.length}');

    for (var packageDoc in packageSnapshot.docs) {
      if (packageDoc.exists) {
        // Check if the document contains the necessary fields
        Map<String, dynamic>? data = packageDoc.data() as Map<String, dynamic>?;
        if (data != null &&
            data.containsKey('id') &&
            data.containsKey('name') &&
            data.containsKey('price') &&
            data.containsKey('features')) {

          packageList.add(
            Package(
              id: data['id'], // Assuming 'id' is stored as a string
              name: data['name'],
              price: (data['price'] ?? 0.0).toDouble(),
              features: List<String>.from(data['features'] ?? []),
            ),
          );
        } else {
          print('Missing required fields in package document: ${packageDoc.id}');
        }
      } else {
        print('Package document does not exist: ${packageDoc.id}');
      }
    }

    return packageList;
  }
  Future<List<UserFeedback>> fetchUserFeedback() async {
    List<UserFeedback> feedbackList = [];

    // Fetch the 'userfeedback' collection
    QuerySnapshot feedbackSnapshot = await FirebaseFirestore.instance
        .collection('userfeedback')
        .get();

    // Debugging: print the number of feedback docs fetched
    print('Number of feedback documents: ${feedbackSnapshot.docs.length}');

    for (var feedbackDoc in feedbackSnapshot.docs) {
      if (feedbackDoc.exists) {
        // Check if the document contains the necessary fields
        Map<String, dynamic>? data = feedbackDoc.data() as Map<String, dynamic>?;
        if (data != null &&
            data.containsKey('date') &&
            data.containsKey('email') &&
            data.containsKey('feedback') &&
            data.containsKey('id') &&
            data.containsKey('name') &&
            data.containsKey('rating')) {

          feedbackList.add(
            UserFeedback(
              date: data['date'],
              email: data['email'],
              feedback: data['feedback'],
              id: data['id'],
              name: data['name'],
              rating: (data['rating'] ?? 0.0).toDouble(),
            ),
          );
        } else {
          print('Missing required fields in feedback document: ${feedbackDoc.id}');
        }
      } else {
        print('Feedback document does not exist: ${feedbackDoc.id}');
      }
    }

    return feedbackList;
  }



}