import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import '../Model/UserFeedBack.dart'; // For formatting the date

class FeedbackPage extends StatefulWidget {
  @override
  _FeedbackPageState createState() => _FeedbackPageState();
}

class _FeedbackPageState extends State<FeedbackPage> {
  List<UserFeedback> feedbackList = [
    UserFeedback(
      id: '1',
      name: 'John Doe',
      email: 'john@example.com',
      date: DateTime.now().subtract(Duration(days: 1)),
      rating: 4.5,
      feedback: 'Great app, very useful!',
    ),
    UserFeedback(
      id: '2',
      name: 'Jane Smith',
      email: 'jane@example.com',
      date: DateTime.now().subtract(Duration(days: 2)),
      rating: 3.0,
      feedback: 'Good but needs some improvements.',
    ),
  ];

  // Function to delete feedback
  void deleteFeedback(String id) {
    setState(() {
      feedbackList.removeWhere((feedback) => feedback.id == id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Feedback'),
      ),
      body: ListView.builder(
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
                  Text('Date: ${feedback.date.day.toString()}-${feedback.date.month.toString()}-${feedback.date.year.toString()}'),
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
                  // Delete feedback
                  deleteFeedback(feedback.id);
                },
              ),
            ),
          );
        },
      ),
    );
  }
}

