import 'package:cloud_firestore/cloud_firestore.dart';
import '../Model/Package.dart';

class PackageOperation {
  final CollectionReference packageCollection =
  FirebaseFirestore.instance.collection('package'); // Ensure this matches Firestore

  // Fetch all packages with document IDs
  Future<List<Package>> fetchPackages() async {
    try {
      final querySnapshot = await packageCollection.get();
      return querySnapshot.docs.map((doc) {
        return Package(
          docId: doc.id,
          name: doc['name'],
          price: doc['price'],
          features: List<String>.from(doc['features']),
        );
      }).toList();
    } catch (e) {
      print('Error fetching packages: $e');
      return [];
    }
  }
  Future<void> addPackage(Package package) async {
    try {
      print('Adding package: ${package.name}, Price: ${package.price}, Features: ${package.features}');
      await packageCollection.add({
        'name': package.name,
        'price': package.price,
        'features': package.features,
      });
      print('Package added successfully');
    } on FirebaseException catch (e) {
      print('FirebaseException error adding package: ${e.message}');
    } catch (e) {
      print('Unknown error adding package: $e');
    }
  }


  // Update an existing package using its document ID
  Future<void> updatePackage(String docId, Package package) async {
    try {
      await packageCollection.doc(docId).update({
        'name': package.name,
        'price': package.price,
        'features': package.features,
      });
      print('Package updated successfully');
    } catch (e) {
      print('Error updating package with ID $docId: $e');
    }
  }

  // Delete a package from Firestore using its document ID
  Future<void> deletePackage(String docId) async {
    try {
      await packageCollection.doc(docId).delete();
      print('Package deleted successfully');
    } catch (e) {
      print('Error deleting package with ID $docId: $e');
    }
  }
}




