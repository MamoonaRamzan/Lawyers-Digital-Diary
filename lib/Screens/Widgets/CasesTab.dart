import 'package:flutter/material.dart';
import 'package:lawyers_digital_diary/Screens/Widgets/CaseDetails.dart';
import '../../Model/Case.dart';

class CasesTab extends StatefulWidget {
  final List<Case> Cases;

  const CasesTab({Key? key, required this.Cases}) : super(key: key);

  @override
  State<CasesTab> createState() => _CasesTabState();
}

class _CasesTabState extends State<CasesTab> {
  late List<Case> _filteredCases;

  TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _filteredCases = widget.Cases;
    _searchController.addListener(_filterClients);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _filterClients() {
    String searchTerm = _searchController.text.toLowerCase();
    setState(() {
      if (searchTerm.isEmpty) {
        _filteredCases = widget.Cases;
      } else {
        _filteredCases = widget.Cases.where((cases) {
          return cases.caseTitle.toLowerCase().contains(searchTerm) ||
              cases.caseId.toLowerCase().contains(searchTerm);
        }).toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search by title or id',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(27.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Color(0xFF4DB6AC), width: 2.0),
                  borderRadius: BorderRadius.circular(27.0),
                ),
                prefixIcon: const Icon(Icons.search),
              ),
            ),
          ),
          Expanded(
            child: _filteredCases.isNotEmpty
                ? ListView.builder(
              itemCount: _filteredCases.length,
              itemBuilder: (context, index) {
                final Case = _filteredCases[index];
                return Card(
                  child: ListTile(
                    trailing: IconButton(
                      icon: const Icon(Icons.navigate_next, color: Colors.black,),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CaseDetails(hearingDate: Case.hearingDates, LawyerNotes: Case.lawyerNotes, Description: Case.caseDescription, CaseTiltle: Case.caseTitle)
                          ),
                        );

                      },
                    ),
                    title: Text(
                      Case.caseTitle,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF4DB6AC),
                      ),
                    ),
                    subtitle: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Case ID",style: TextStyle(
                                fontWeight:FontWeight.bold
                            ),),
                            Text(Case.caseId),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Client ID",style: TextStyle(
                                fontWeight:FontWeight.bold
                            ),),
                            Text(Case.clientId),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Office File No",style: TextStyle(
                                fontWeight:FontWeight.bold
                            ),),
                            Text(Case.officeFileNumber),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Court",style: TextStyle(
                                fontWeight:FontWeight.bold
                            ),),
                            Text(Case.court),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Court Case Number",style: TextStyle(
                                fontWeight:FontWeight.bold
                            ),),
                            Text(Case.courtCaseNumber),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Judge Name",style: TextStyle(
                                fontWeight:FontWeight.bold
                            ),),
                            Text(Case.judgeName),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Status",style: TextStyle(
                                fontWeight:FontWeight.bold
                            ),),
                            Text(Case.status),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Start Date",style: TextStyle(
                                fontWeight:FontWeight.bold
                            ),),
                            Text(Case.startDate),
                          ],
                        ),
                      ],
                    ),
                    onTap: () {
                      // Handle client detail navigation or actions
                    },
                  ),
                );
              },
            )
                : const Center(child: Text('No case found')),
          ),
        ],
      ),
    );
  }
}
