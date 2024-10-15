import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:lawyers_digital_diary/FirebaseServices/fetch_data.dart';
import '../Model/UserFeedBack.dart'; // For formatting the date

class FeedbackPage extends StatefulWidget {
  @override
  _FeedbackPageState createState() => _FeedbackPageState();
}

class _FeedbackPageState extends State<FeedbackPage> {
  final FetchData dataService = FetchData();

  // Function to delete feedback (You would also need to delete from Firestore)
  void deleteFeedback(String id) {
    setState(() {
      // Assuming feedbackList is a List, this function would be passed inside the FutureBuilder logic
      // You need to implement Firestore deletion as well in your fetch_data.dart service.
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Feedback'),
      ),
      body: FutureBuilder<List<UserFeedback>>(
        future: dataService.fetchUserFeedback(), // Fetching feedback from Firestore
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // While the data is loading
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            // In case of an error
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            // No data available
            return Center(child: Text('No feedback available'));
          }

          // Data is available
          final feedbackList = snapshot.data!;

          return ListView.builder(
            itemCount: feedbackList.length,
            itemBuilder: (context, index) {
              final feedback = feedbackList[index];
              return Card(
                margin: EdgeInsets.all(10),
                child: ListTile(
                  title: Text(feedback.name),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Email: ${feedback.email}'),
                      Text('Date: ${feedback.date}'),
                      Row(
                        children: [
                          Text('Rating: '),
                          RatingBarIndicator(
                            rating: feedback.rating,
                            itemBuilder: (context, index) => Icon(
                              Icons.star,
                              color: Colors.amber,
                            ),
                            itemCount: 5,
                            itemSize: 20.0,
                            direction: Axis.horizontal,
                          ),
                        ],
                      ),
                      Text('Feedback: ${feedback.feedback}'),
                    ],
                  ),
                  trailing: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      // Delete feedback from UI and Firestore
                      deleteFeedback(feedback.id);
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


