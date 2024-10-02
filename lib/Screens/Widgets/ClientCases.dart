import 'package:flutter/material.dart';

import '../../Model/Case.dart';
import '../../Model/Client.dart';


class ClientCases extends StatelessWidget {
  final List<Case> clientCase;
  final String clientName;

  ClientCases({Key? key, required this.clientCase, required this.clientName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(clientName),
      ),
      body: Expanded(
        child : ListView.builder(
          itemCount: clientCase.length,
          itemBuilder: (context, index) {
            return Card(
              child: ListTile(
                title: Text(
                  clientCase[index].caseTitle,
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
                        Text("Case ID ",style: TextStyle(
                            fontWeight:FontWeight.bold
                        ),),
                        Text(clientCase[index].caseId),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Court ",style: TextStyle(
                            fontWeight:FontWeight.bold
                        ),),
                        Text(clientCase[index].court),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Judge Name",style: TextStyle(
                            fontWeight:FontWeight.bold
                        ),),
                        Text(clientCase[index].judgeName),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Start Date",style: TextStyle(
                            fontWeight:FontWeight.bold
                        ),),
                        Text(clientCase[index].startDate.day.toString()+"-"+clientCase[index].startDate.month.toString()+"-"+clientCase[index].startDate.year.toString()),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Status",style: TextStyle(
                            fontWeight:FontWeight.bold
                        ),),
                        Text(clientCase[index].status),
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Case Description",style: TextStyle(
                            fontWeight:FontWeight.bold
                        ),),
                        Text(clientCase[index].caseDescription),
                      ],
                    ),

                  ],
                ),
              ),
            );
          },
        )
      ),
    );
  }
}
