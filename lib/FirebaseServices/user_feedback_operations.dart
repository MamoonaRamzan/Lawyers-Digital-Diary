import 'package:cloud_firestore/cloud_firestore.dart';
import '../Model/UserFeedBack.dart';

class UserFeedbackOperation {
  final CollectionReference userFeedbackCollection =
  FirebaseFirestore.instance.collection('userfeedback'); // Ensure this matches Firestore

  // Fetch all user feedback
  Future<List<UserFeedback>> fetchUserFeedback() async {
    List<UserFeedback> feedbackList = [];

    try {
      final querySnapshot = await userFeedbackCollection.get();
      for (var feedbackDoc in querySnapshot.docs) {
        if (feedbackDoc.exists) {
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
                id: feedbackDoc.id, // Use Firestore doc ID
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
    } catch (e) {
      print('Error fetching user feedback: $e');
    }

    return feedbackList;
  }

  // Delete a feedback document from Firestore using its document ID
  Future<void> deleteUserFeedback(String docId) async {
    try {
      await userFeedbackCollection.doc(docId).delete();
      print('Feedback with ID $docId deleted successfully');
    } catch (e) {
      print('Error deleting feedback with ID $docId: $e');
    }
  }
}
