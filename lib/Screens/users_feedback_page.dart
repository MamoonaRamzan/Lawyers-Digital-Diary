import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:lawyers_digital_diary/FirebaseServices/lawyer_operations.dart';
import '../FirebaseServices/user_feedback_operations.dart';
import '../Model/UserFeedBack.dart';
// Import the new operation class

class FeedbackPage extends StatefulWidget {
  @override
  _FeedbackPageState createState() => _FeedbackPageState();
}

class _FeedbackPageState extends State<FeedbackPage> {
  final UserFeedbackOperation feedbackOperation = UserFeedbackOperation();
  late Future<List<UserFeedback>> feedbackFuture;

  @override
  void initState() {
    super.initState();
    feedbackFuture = feedbackOperation.fetchUserFeedback(); // Initial fetch
  }

  // Method to delete feedback
  void deleteFeedback(String id) async {
    try {
      await feedbackOperation.deleteUserFeedback(id); // Delete from Firestore
      setState(() {
        feedbackFuture = feedbackOperation.fetchUserFeedback(); // Refresh the list
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Feedback deleted successfully')),
      );
    } catch (e) {
      print('Error deleting feedback: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to delete feedback: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Feedback'),
        centerTitle: true,
      ),
      body: FutureBuilder<List<UserFeedback>>(
        future: feedbackFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator(color: Color(0xFF4DB6AC)));
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No feedback available'));
          }

          final feedbackList = snapshot.data!;

          return ListView.builder(
            itemCount: feedbackList.length,
            itemBuilder: (context, index) {
              final feedback = feedbackList[index];
              return Card(
                margin: EdgeInsets.all(10),
                child: ListTile(
                  title: Text(feedback.name,
                    style: TextStyle(
                      color: Color(0xFF4DB6AC),
                      fontWeight: FontWeight.bold,
                      fontSize: 18
                    ),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Email: ${feedback.email}',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14
                        ),
                      ),
                      Text('Date: ${feedback.date}',
                          style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14
                      ),
                      ),
                      Row(
                        children: [
                          Text('Rating: ',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14
                            ),
                          ),
                          RatingBarIndicator(
                            rating: feedback.rating,
                            itemBuilder: (context, index) => Icon(
                              Icons.star,
                              color:Color(0xFF4DB6AC)
                            ),
                            itemCount: 5,
                            itemSize: 20.0,
                            direction: Axis.horizontal,
                          ),
                        ],
                      ),
                      Text('Feedback: ${feedback.feedback}',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14
                        ),
                      ),
                    ],
                  ),
                  trailing: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      // Confirm deletion
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: Text('Delete Feedback'),
                          content: Text('Are you sure you want to delete this feedback?'),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop(); // Close dialog
                              },
                              child: Text('Cancel'),
                            ),
                            TextButton(
                              onPressed: () {
                                deleteFeedback(feedback.id); // Call delete function
                                Navigator.of(context).pop(); // Close dialog
                              },
                              child: Text('Delete'),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}


