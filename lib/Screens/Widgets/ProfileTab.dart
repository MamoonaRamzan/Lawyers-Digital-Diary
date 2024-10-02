import 'package:flutter/material.dart';

import '../../Model/Lawyer.dart';
import '../../Model/Profile.dart';
class ProfileTab extends StatelessWidget {
  final Profile profile;

  ProfileTab({required this.profile});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 70,
            backgroundColor: Color(0xFF4DB6AC),
            child: Icon(Icons.person,size: 100,color: Colors.white),
            //backgroundImage: NetworkImage(lawyer.profilePicture),
          ),
          SizedBox(height: 50),
        Table(
          border: TableBorder(
            top: BorderSide(
              color: Color(0xFF4DB6AC),
              width: 3
            ),
            bottom: BorderSide(
                color: Color(0xFF4DB6AC),
                width: 3
            ),
            /*verticalInside: BorderSide(
                color: Color(0xFF4DB6AC),
                width: 3
            ),*/
            right:BorderSide(
                color: Color(0xFF4DB6AC),
                width: 3
            ),
            left: BorderSide(
              color: Color(0xFF4DB6AC),
              width: 3
            ),
            /*horizontalInside: BorderSide(
              color: Colors.black,
              width: 1
            )*/
          ),
          columnWidths: const {
            0: FlexColumnWidth(2.3), // First column width
            1: FlexColumnWidth(3), // Second column width
          },
          children: [
            TableRow(
              children: [
                Text(' Full Name', style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold)),
                Text('${profile.name}', style: TextStyle(fontSize: 18)),
              ],
            ),
            TableRow(
              children: [
                Text(' Email', style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold)),
                Text('${profile.email}', style: TextStyle(fontSize: 18)),
              ],
            ),
            TableRow(
              children: [
                Text(' Phone', style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold)),
                Text('${profile.phone}', style: TextStyle(fontSize: 18)),
              ],
            ),
            TableRow(
              children: [
                Text(' Specialization', style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold)),
                Text('${profile.specialization}', style: TextStyle(fontSize: 18)),
              ],
            ),
            /*TableRow(
              children: [
                Text(' No of Cases', style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold)),
                Text('${profile.activeCases.toString()} years', style: TextStyle(fontSize: 18)),
              ],
            ),*/
            TableRow(
              children: [
                Text(' Firm', style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold)),
                Text('${profile.firmName}', style: TextStyle(fontSize: 18)),
              ],
            ),
            TableRow(
              children: [
                Text(' Office Address', style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold)),
                Text('${profile.ChamberAddress}', style: TextStyle(fontSize: 18)),
              ],
            ),
            TableRow(
              children: [
                Text(' Court Affiliation', style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold)),
                Text('${profile.courtAffiliation}', style: TextStyle(fontSize: 18)),
              ],
            ),
          ],
        )
        ],
      ),
    );
  }
}
