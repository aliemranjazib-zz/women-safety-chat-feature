import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ResolvedHistoryScreen extends StatelessWidget {
  const ResolvedHistoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Resolved History'),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('users')
            .where('type', isEqualTo: 'patient')
            .where('mode', isEqualTo: 'resolved')
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
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ExpansionTile(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text("Change"),
                              ElevatedButton(
                                  onPressed: () async {
                                    await FirebaseFirestore.instance
                                        .collection('users')
                                        .doc(FirebaseAuth
                                            .instance.currentUser!.uid)
                                        .update({'mode': 'open'});

                                    await FirebaseFirestore.instance
                                        .collection('users')
                                        .doc(d.id)
                                        .update({'mode': 'open'});
                                  },
                                  child: Text("Change to open mode")),
                            ],
                          ),
                        ],
                        leading: CircleAvatar(
                          radius: 20.0,
                          backgroundImage:
                              AssetImage('images/patient_login.png'),
                          backgroundColor: Colors.transparent,
                        ),
                        title: Text(
                          d['name'],
                        ),
                        // trailing: IconButton(
                        //     onPressed: () {
                        //       // Navigator.push(
                        //       //     context,
                        //       //     MaterialPageRoute(
                        //       //         builder: (_) => ChatScreen(
                        //       //             currentUserId: FirebaseAuth
                        //       //                 .instance
                        //       //                 .currentUser!
                        //       //                 .uid,
                        //       //             friendId: d.id,
                        //       //             friendName: d['name'])));
                        //     },
                        //     icon: Icon(Icons.chat)),
                      ),
                    )),
              );
            },
          );
        },
      ),
    );
  }
}
