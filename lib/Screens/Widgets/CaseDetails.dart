import 'package:flutter/material.dart';
class CaseDetails extends StatelessWidget {
  final List <DateTime> hearingDate;
  final String CaseTiltle;
  final String Description;
  final String LawyerNotes;
  const CaseDetails({super.key,required this.hearingDate,required this.LawyerNotes,required this.Description, required this.CaseTiltle});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(CaseTiltle),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Description"),
          Text(Description),
          Text("Lawyers Notes"),
          Text(LawyerNotes),
          Text("Hearing Dates"),
          Expanded(
            child: ListView.builder(
                itemCount: hearingDate.length,
                itemBuilder: (context,index){
                  return Text(hearingDate[index].day.toString()+"-"+hearingDate[index].month.toString()+"-"+hearingDate[index].year.toString());
                }),
          ),
        ],
      ),
    );
  }
}
