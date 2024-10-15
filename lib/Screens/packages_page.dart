import 'package:flutter/material.dart';
import 'package:lawyers_digital_diary/FirebaseServices/fetch_data.dart';
import '../Model/Package.dart';

class PackagesPage extends StatefulWidget {
  @override
  _PackagesPageState createState() => _PackagesPageState();
}

class _PackagesPageState extends State<PackagesPage> {
  FetchData data = FetchData();

  // Function to update a pricing plan
  void updatePricingPlan(Package updatedPlan) {
    setState(() {
      // You would want to use a state management solution or update the data in Firestore
    });
  }

  // Function to delete a pricing plan
  void deletePricingPlan(String id) {
    setState(() {
      // You would want to implement the deletion logic in Firestore as well
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pricing Plans'),
      ),
      body: FutureBuilder<List<Package>>(
        future: data.fetchPackages(), // Fetch packages here
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No packages available.'));
          }

          final packages = snapshot.data!; // Get the data

          return ListView.builder(
            itemCount: packages.length,
            itemBuilder: (context, index) {
              final plan = packages[index];
              return Card(
                child: ListTile(
                  title: Text(plan.name),
                  subtitle: Text('\$${plan.price.toStringAsFixed(2)}'),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(Icons.edit),
                        onPressed: () {
                          _showEditDialog(plan);
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () {
                          deletePricingPlan(plan.id.toString());
                        },
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showAddDialog();
        },
        child: Icon(Icons.add),
      ),
    );
  }

  // Dialog to add new pricing plan
  void _showAddDialog() {
    String name = '';
    double price = 0.0;
    List<String> features = [];

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Add Pricing Plan'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  onChanged: (value) => name = value,
                  decoration: InputDecoration(labelText: 'Plan Name'),
                ),
                TextField(
                  onChanged: (value) => price = double.tryParse(value) ?? 0.0,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(labelText: 'Price'),
                ),
                // Add more input for features or handle differently
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                if (name.isNotEmpty) {
                  setState(() {
                    // You would want to implement the logic to add the new plan to Firestore here
                  });
                }
                Navigator.of(context).pop();
              },
              child: Text('Add'),
            ),
          ],
        );
      },
    );
  }

  // Dialog to edit an existing pricing plan
  void _showEditDialog(Package package) {
    String name = package.name;
    double price = package.price;

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Edit Pricing Plan'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  onChanged: (value) => name = value,
                  decoration: InputDecoration(labelText: 'Plan Name'),
                  controller: TextEditingController(text: package.name),
                ),
                TextField(
                  onChanged: (value) => price = double.tryParse(value) ?? package.price,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(labelText: 'Price'),
                  controller: TextEditingController(text: package.price.toString()),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                updatePricingPlan(Package(id: package.id, name: name, price: price, features: package.features));
                Navigator.of(context).pop();
              },
              child: Text('Update'),
            ),
          ],
        );
      },
    );
  }
}


