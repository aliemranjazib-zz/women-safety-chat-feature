import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:women_safety_fyp/screens/guardian_screen/guardian_info_page.dart';
import 'package:flutter/material.dart';

class GuardianDetailScreen extends StatelessWidget {
  String? speciality;
  GuardianDetailScreen({this.speciality});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("$speciality"),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('users')
            .where('specialization', isEqualTo: speciality)
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }
          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (BuildContext context, int index) {
              final d = snapshot.data!.docs[index];
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(color: Colors.grey.shade400)),
                  child: ListTile(
                    leading: CircleAvatar(
                      radius: 20.0,
                      backgroundImage: AssetImage('images/doc.png'),
                      backgroundColor: Colors.transparent,
                    ),
                    title: Text("Doctor ${d['name']}"),
                    trailing: IconButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => GurdianInfo(
                                        Name: d['name'],
                                        info: d['info'],
                                        id: d.id,
                                        email: d['email'],
                                        // specialization: d['specialization'],
                                      )));
                        },
                        icon: Icon(Icons.navigate_next)),
                  ),
                ),

                // child: Container(
                //   decoration:
                //       BoxDecoration(border: Border.all(color: Colors.grey)),
                //   //color: Colors.amber,
                //   child: Padding(
                //     padding: const EdgeInsets.all(8.0),
                //     child: Text(d['name']),
                //   ),
                // ),
              );
            },
          );
        },
      ),
    );
  }
}
