import 'package:flutter/material.dart';

import '../Model/Package.dart';

class PackagesPage extends StatefulWidget {
  @override
  _PackagesPageState createState() => _PackagesPageState();
}

class _PackagesPageState extends State<PackagesPage> {
  List<Package> packages = [
    Package(id: '1', name: 'Basic Plan', price: 9.99, features: ['Feature A', 'Feature B']),
    Package(id: '2', name: 'Pro Plan', price: 19.99, features: ['Feature A', 'Feature B', 'Feature C']),
    Package(id: '3', name: 'Enterprise Plan', price: 49.99, features: ['Feature A', 'Feature B', 'Feature C', 'Feature D']),
  ];

  // Function to update a pricing plan
  void updatePricingPlan(Package updatedPlan) {
    setState(() {
      int index = packages.indexWhere((plan) => plan.id == updatedPlan.id);
      if (index != -1) {
        packages[index] = updatedPlan;
      }
    });
  }

  // Function to delete a pricing plan
  void deletePricingPlan(String id) {
    setState(() {
      packages.removeWhere((plan) => plan.id == id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pricing Plans'),
      ),
      body: ListView.builder(
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
                      // Navigate to the update page or dialog
                      _showEditDialog(plan);
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      deletePricingPlan(plan.id);
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Add a new pricing plan
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
              mainAxisSize: MainAxisSize.min, // This ensures the dialog doesn't take up the whole height
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
                    packages.add(
                      Package(id: DateTime.now().toString(), name: name, price: price, features: features),
                    );
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
              mainAxisSize: MainAxisSize.min, // Ensures the dialog takes only the required height
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

