import 'package:flutter/material.dart';
import 'package:lawyers_digital_diary/Screens/Widgets/ClientCases.dart';

import '../../Model/Client.dart';


class ClientsPage extends StatefulWidget {
  final List<Client> clients;

  const ClientsPage({Key? key, required this.clients}) : super(key: key);

  @override
  State<ClientsPage> createState() => _ClientsPageState();
}

class _ClientsPageState extends State<ClientsPage> {
  late List<Client> _filteredClients;

  TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _filteredClients = widget.clients;
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
        _filteredClients = widget.clients;
      } else {
        _filteredClients = widget.clients.where((client) {
          return client.name.toLowerCase().contains(searchTerm) ||
              client.email.toLowerCase().contains(searchTerm);
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
                hintText: 'Search by name or email',
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
            child: _filteredClients.isNotEmpty
                ? ListView.builder(
              itemCount: _filteredClients.length,
              itemBuilder: (context, index) {
                final client = _filteredClients[index];
                return Card(
                  child: ListTile(
                    /*leading: const CircleAvatar(
                      backgroundColor: Color(0xFF4DB6AC),
                      child: Icon(Icons.person, color: Colors.white),
                    ),*/
                    trailing: IconButton(
                      icon: const Icon(Icons.navigate_next),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ClientCases(clientCase: client.caseList,clientName: client.name,),
                          ),
                        );
                        
                      },
                    ),
                    title: Text(
                      client.name,
                      style: const TextStyle(
                        fontSize: 17,
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
                            Text("Client ID ",style: TextStyle(
                                fontWeight:FontWeight.bold
                            ),),
                            Text(client.clientId),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Client Type",style: TextStyle(
                                fontWeight:FontWeight.bold
                            ),),
                            Text(client.clientType),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Email ",style: TextStyle(
                              fontWeight:FontWeight.bold
                            ),),
                            Text(client.email),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Phone",style: TextStyle(
                                fontWeight:FontWeight.bold
                            ),),
                            Text(client.phone),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("OnBoard Date",style: TextStyle(
                                fontWeight:FontWeight.bold
                            ),),
                            Text(client.onboardDate),
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Address ",style: TextStyle(
                                fontWeight:FontWeight.bold
                            ),),
                            Text(client.address),
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
                : const Center(child: Text('No client found')),
          ),
        ],
      ),
    );
  }
}



