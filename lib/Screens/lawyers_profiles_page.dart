import 'package:flutter/material.dart';
import '../Model/Case.dart';
import '../Model/Client.dart';
import '../Model/Lawyer.dart';
import '../Model/Profile.dart';
import '../Model/Shedule.dart';
import 'lawyers_details.dart';

class LawyersProfilePage extends StatefulWidget {
  const LawyersProfilePage({super.key});

  @override
  State<LawyersProfilePage> createState() => _LawyersProfilePageState();
}

class _LawyersProfilePageState extends State<LawyersProfilePage> {
  final List<Lawyer> lawyers = [
    Lawyer(
      profile: Profile(
        name: 'John Doe',
        email: 'john.doe@example.com',
        phone: '+923338171175',
        password: 'Password',
        firmName: 'XYZ',
        ChamberAddress: '156 Main',
        specialization: 'Criminal Law',
        //photoUrl: 'path_to_photo.jpg',
        courtAffiliation: 'Supreme Court',
        package: 'pro'

      ),
      clients: [
        Client(
          clientId: 'C001',
          name: 'Jane Smith',
          email: 'jane.smith@example.com',
          phone: "+923338171175",
          address: '123 Main St',
          onboardDate: DateTime.now(),
          clientType: 'Individual',
          caseList: [
            Case(
              caseId: 'CA001',
              clientId: 'C001',
              caseTitle: 'Theft Case',
              officeFileNumber: '009',
              court: 'Supreme Court',
              courtCaseNumber: '307',
              judgeName: 'Jhony',
              caseDescription: 'A theft case description',
              status: 'open',
              startDate: DateTime.now(),
              hearingDates: [DateTime.now().add(Duration(days: 30))],
              lawyerNotes: 'Initial hearing done',
            ),
          ],
        ),
      ],
      cases: [
        Case(
          caseId: 'CA001',
          clientId: 'C001',
          caseTitle: 'Theft Case',
          officeFileNumber: '009',
          court: 'Supreme Court',
          courtCaseNumber: '307',
          judgeName: 'Jhony',
          caseDescription: 'A theft case description',
          status: 'open',
          startDate: DateTime.now(),
          hearingDates: [DateTime.now().add(Duration(days: 30))],
          lawyerNotes: 'Initial hearing done',
        ),
      ],
      schedule: [
        Schedule(
          scheduleId: 'S001',
          caseId: 'CA001',
          clientId: 'C001',
          dateTime: DateTime.now().add(Duration(days: 7)),
          description: 'Court hearing',
          location: 'Courtroom 3A',
          reminder: true,
        ),
      ],
    ),
    // Add more lawyers here
  ];

  // Search text controller
  TextEditingController _searchController = TextEditingController();

  // List to store filtered lawyers (initially contains all lawyers)
  List<Lawyer> _filteredLawyers = [];

  @override
  void initState() {
    super.initState();
    // Initially show all lawyers
    _filteredLawyers = lawyers;
    _searchController.addListener(_filterLawyers);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  // This method filters the lawyers list based on search input
  void _filterLawyers() {
    String searchTerm = _searchController.text.toLowerCase();
    setState(() {
      if (searchTerm.isEmpty) {
        // If search term is empty, show all lawyers
        _filteredLawyers = lawyers;
      } else {
        // Filter lawyers based on name or email
        _filteredLawyers = lawyers.where((lawyer) {
          return lawyer.profile.name.toLowerCase().contains(searchTerm) ||
              lawyer.profile.email.toLowerCase().contains(searchTerm);
        }).toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lawyers'),
        centerTitle: true,
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(60.0),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search by name or email',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(27.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFF4DB6AC), width: 2.0),
                  borderRadius: BorderRadius.circular(27.0),// Border when focused
                ),
                prefixIcon: Icon(Icons.search),
              ),
            ),
          ),
        ),
      ),
      body: _filteredLawyers.isNotEmpty
          ? ListView.builder(
        itemCount: _filteredLawyers.length,
        itemBuilder: (context, index) {
          final lawyer = _filteredLawyers[index];
          return Card(
            child: ListTile(
              leading: CircleAvatar(
                //backgroundImage: NetworkImage(lawyer.profilePicture),
                backgroundColor: Color(0xFF4DB6AC),
                child: Icon(Icons.person, color: Colors.white,),
              ),
              trailing: IconButton(
                icon: Icon(Icons.delete),
                onPressed: () {
                  setState(() {
                    // Get the lawyer's email to remove from both lists
                    final lawyerToRemove = _filteredLawyers[index];

                    // Remove from both filtered and main lists
                    _filteredLawyers.remove(lawyerToRemove);
                    lawyers.removeWhere((lawyer) => lawyer.profile.email == lawyerToRemove.profile.email);
                  });
                },
              ),
              title: Text(lawyer.profile.name, style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold,
                color: Color(0xFF4DB6AC)
              ),),
              subtitle: Text(
                  lawyer.profile.email,
                  style: TextStyle(
                      //color: Color(0xFF4DB6AC
                      //)
              )
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        LawyerDetail(lawyer: lawyer), // Full profile screen
                  ),
                );
              },
            ),
          );
        },
      )
          : Center(
        child: Text('No user found'),
      ),
    );
  }
}





