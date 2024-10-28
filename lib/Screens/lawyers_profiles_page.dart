import 'package:flutter/material.dart';
import 'package:lawyers_digital_diary/FirebaseServices/lawyer_operations.dart';
import '../Model/Lawyer.dart';
import 'lawyers_details.dart';

class LawyersProfilePage extends StatefulWidget {
  const LawyersProfilePage({super.key});

  @override
  State<LawyersProfilePage> createState() => _LawyersProfilePageState();
}

class _LawyersProfilePageState extends State<LawyersProfilePage> {
  LawyerOperations data = LawyerOperations();
  Future<List<Lawyer>>? lawyersFuture;

  // Search text controller
  TextEditingController _searchController = TextEditingController();

  // List to store filtered lawyers (initially contains all lawyers)
  List<Lawyer> _filteredLawyers = [];
  List<Lawyer> _lawyers = []; // To store the fetched list of lawyers

  @override
  void initState() {
    super.initState();
    // Fetch lawyers and store in the state
    lawyersFuture = data.fetchLawyers();
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
        _filteredLawyers = _lawyers;
      } else {
        // Filter lawyers based on name or email
        _filteredLawyers = _lawyers.where((lawyer) {
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
                  borderRadius: BorderRadius.circular(27.0),
                ),
                prefixIcon: Icon(Icons.search),
              ),
            ),
          ),
        ),
      ),
      body: FutureBuilder<List<Lawyer>>(
        future: lawyersFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator(color: Color(0xFF4DB6AC),));
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            // Store fetched data in _lawyers and show in _filteredLawyers
            _lawyers = snapshot.data!;
            _filteredLawyers = _filteredLawyers.isEmpty ? _lawyers : _filteredLawyers;

            return _filteredLawyers.isNotEmpty
                ? ListView.builder(
              itemCount: _filteredLawyers.length,
              itemBuilder: (context, index) {
                final lawyer = _filteredLawyers[index];
                return Card(
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Color(0xFF4DB6AC),
                      child: Icon(Icons.person, color: Colors.white),
                    ),
                    trailing: IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () async {
                        // Get the lawyer's ID to remove from Firestore
                        final lawyerToRemove = _filteredLawyers[index];

                        // Show a confirmation dialog before deletion (optional)
                        final confirmDelete = await showDialog<bool>(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text('Confirm Delete'),
                              content: Text('Are you sure you want to delete ${lawyerToRemove.profile.name}?'),
                              actions: <Widget>[
                                TextButton(
                                  child: Text('Cancel'),
                                  onPressed: () => Navigator.of(context).pop(false),
                                ),
                                TextButton(
                                  child: Text('Delete'),
                                  onPressed: () => Navigator.of(context).pop(true),
                                ),
                              ],
                            );
                          },
                        );

                        // If the user confirms deletion
                        if (confirmDelete == true) {
                          try {
                            // Call the deleteLawyer method from LawyerOperations
                            await data.deleteLawyer(lawyerToRemove.id); // Use the correct ID for your lawyer object

                            // Remove from both filtered and main lists
                            setState(() {
                              _filteredLawyers.remove(lawyerToRemove);
                              _lawyers.removeWhere((lawyer) => lawyer.profile.email == lawyerToRemove.profile.email);
                            });

                            // Show success message
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Lawyer ${lawyerToRemove.profile.name} deleted successfully')),
                            );
                          } catch (e) {
                            // Handle any errors during deletion
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Error deleting lawyer: $e')),
                            );
                          }
                        }
                      },
                    ),
                    title: Text(
                      lawyer.profile.name,
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF4DB6AC),
                      ),
                    ),
                    subtitle: Text(lawyer.profile.email),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => LawyerDetail(lawyer: lawyer), // Full profile screen
                        ),
                      );
                    },
                  ),
                );
              },
            )
                : Center(child: Text('No user found'));
          } else {
            return Center(child: Text('No lawyers available'));
          }
        },
      ),
    );
  }
}






