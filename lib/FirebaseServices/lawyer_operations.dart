import 'package:cloud_firestore/cloud_firestore.dart';
import '../Model/Case.dart';
import '../Model/Client.dart';
import '../Model/Lawyer.dart';
import '../Model/Profile.dart';
import '../Model/Shedule.dart';


class LawyerOperations {
  final CollectionReference lawyerCollection =
  FirebaseFirestore.instance.collection('Lawyer'); // Ensure this matches Firestore

  // Fetch all lawyers
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

      // Create Lawyer object with document ID
      Lawyer lawyer = Lawyer(
        id: lawyerDoc.id, // Capture the document ID here
        profile: profile,
        clients: clients,
        cases: cases,
        schedule: schedule,
      );

      lawyersList.add(lawyer);
    }

    return lawyersList;
  }
  // Fetch profile of a lawyer
  Future<Profile> fetchProfile(String lawyerId) async {
    DocumentSnapshot profileDoc = await lawyerCollection
        .doc(lawyerId)
        .collection('Profile')
        .doc('LSZgXc185fkM7o5S11iY') // Replace with your logic to get the profile ID
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

  // Fetch clients of a lawyer
  Future<List<Client>> fetchClients(String lawyerId) async {
    List<Client> clientsList = [];

    QuerySnapshot clientsSnapshot = await lawyerCollection
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

  // Fetch cases list of a client
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

  // Fetch cases of a lawyer
  Future<List<Case>> fetchCases(String lawyerId) async {
    List<Case> casesList = [];

    QuerySnapshot casesSnapshot = await lawyerCollection
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

  // Fetch schedule of a lawyer
  Future<List<Schedule>> fetchSchedule(String lawyerId) async {
    List<Schedule> scheduleList = [];

    // Fetch schedule collection for a lawyer
    QuerySnapshot scheduleSnapshot = await lawyerCollection
        .doc(lawyerId)
        .collection('shedule') // Ensure the collection name is correct
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

  // Delete a lawyer from Firestore using its document ID
  Future<void> deleteLawyer(String lawyerId) async {
    try {
      // Delete the lawyer document
      await lawyerCollection.doc(lawyerId).delete();
      print('Lawyer with ID $lawyerId deleted successfully');

      // Optionally, delete associated subcollections (Profile, clients, cases, schedule)
      await deleteLawyerSubcollections(lawyerId);
    } catch (e) {
      print('Error deleting lawyer with ID $lawyerId: $e');
    }
  }

  // Optional: Method to delete associated subcollections
  Future<void> deleteLawyerSubcollections(String lawyerId) async {
    // Delete Profile
    await lawyerCollection.doc(lawyerId).collection('Profile').doc('LSZgXc185fkM7o5S11iY').delete();

    // Delete clients collection
    var clientsSnapshot = await lawyerCollection.doc(lawyerId).collection('clients').get();
    for (var clientDoc in clientsSnapshot.docs) {
      await clientDoc.reference.delete(); // Delete each client document
    }

    // Delete cases collection
    var casesSnapshot = await lawyerCollection.doc(lawyerId).collection('cases').get();
    for (var caseDoc in casesSnapshot.docs) {
      await caseDoc.reference.delete(); // Delete each case document
    }

    // Delete schedule collection
    var scheduleSnapshot = await lawyerCollection.doc(lawyerId).collection('schedule').get();
    for (var scheduleDoc in scheduleSnapshot.docs) {
      await scheduleDoc.reference.delete(); // Delete each schedule document
    }
  }
}
