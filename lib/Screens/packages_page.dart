import 'package:flutter/material.dart';
import 'package:lawyers_digital_diary/FirebaseServices/lawyer_operations.dart';
import 'package:lawyers_digital_diary/FirebaseServices/package_operations.dart';
import '../Model/Package.dart';

class PackagesPage extends StatefulWidget {
  @override
  _PackagesPageState createState() => _PackagesPageState();
}

class _PackagesPageState extends State<PackagesPage> {
  final PackageOperation packageOperation = PackageOperation();

  void updatePricingPlan(String docId, Package updatedPlan) async {
    await packageOperation.updatePackage(docId, updatedPlan);
    setState(() {});
  }

  void deletePricingPlan(String docId) async {
    await packageOperation.deletePackage(docId);
    setState(() {});
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pricing Plans'),
        centerTitle: true,
      ),
      body: FutureBuilder<List<Package>>(
        future: packageOperation.fetchPackages(), // Fetch packages from Firestore
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator(color: Color(0xFF4DB6AC)));
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No packages available.'));
          }

          final packages = snapshot.data!;

          return ListView.builder(
            itemCount: packages.length,
            itemBuilder: (context, index) {
              final plan = packages[index];

              return Card(
                child: ListTile(
                  title: Text(plan.name,
                    style: TextStyle(
                    color: Color(0xFF4DB6AC),
                    fontSize: 18,
                    fontWeight: FontWeight.bold
                  ),),
                  subtitle: Text('\$${plan.price.toStringAsFixed(2)}',
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.normal
                      )
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(Icons.edit,color: Color(0xFF4DB6AC),),
                        onPressed: () {
                          _showEditDialog(plan);
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () {
                          deletePricingPlan(plan.docId); // Update docId usage as needed
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
        backgroundColor: Color(0xFF4DB6AC),
        foregroundColor: Colors.white,
        onPressed: () {
          _showAddDialog();
        },
        child: Icon(Icons.add),
      ),
    );
  }

  // Dialog to add a new pricing plan with features
  void _showAddDialog() {
    String name = '';
    double price = 0.0;
    List<String> features = [];
    TextEditingController featureController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          surfaceTintColor: Color(0xFF4DB6AC),
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
                  onChanged: (value) {
                    price = double.tryParse(value) ?? 0.0; // Update price on input
                    print('Price: $price'); // Debug statement
                  },
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(labelText: 'Price'),
                ),
                TextField(
                  controller: featureController,
                  decoration: InputDecoration(labelText: 'Features (comma separated)'),
                  // No need for onSubmitted here
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () async {
                // Set features when the Add button is pressed
                features = featureController.text.split(',')
                    .map((feature) => feature.trim())
                    .where((feature) => feature.isNotEmpty)
                    .toList();

                print('Name: $name, Price: $price, Features: $features'); // Debug statement

                // Validation check
                if (name.isNotEmpty && price > 0 && features.isNotEmpty) {
                  try {
                    // Call addPackage and wait for the result
                    await packageOperation.addPackage(Package(
                      docId: '',
                      name: name,
                      price: price,
                      features: features,
                    ));
                    print('Package added: $name, Price: $price, Features: $features'); // Debug statement
                    setState(() {}); // Update UI
                    Navigator.of(context).pop(); // Close the dialog
                  } catch (e) {
                    print('Error adding package: $e'); // Catch any errors
                  }
                } else {
                  print('Please enter valid details'); // Inform user to enter valid data
                }
              },
              child: Text('Add'),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(), // Close dialog without adding
              child: Text('Cancel'),
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
    List<String> features = List.from(package.features);

    TextEditingController featureController = TextEditingController();
    featureController.text = features.join(', ');

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          surfaceTintColor: Color(0xFF4DB6AC),
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
                TextField(
                  controller: featureController,
                  decoration: InputDecoration(labelText: 'Features (comma separated)'),
                  onSubmitted: (value) {
                    features = value.split(',').map((feature) => feature.trim()).toList();
                  },
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                updatePricingPlan(package.docId, Package(
                  docId: package.docId,
                  name: name,
                  price: price,
                  features: features,
                ));
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








