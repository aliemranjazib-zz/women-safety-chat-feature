import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:women_safety_fyp/chat_module/chat_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SelectScreen extends StatelessWidget {
  // const SelectScreen({ Key? key }) : super(key: key);

//  UserModel user;

  // SelectScreen(
  //   this.user,
  // );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 248, 133, 172),
        title: Text('select guardian'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            // ElevatedButton(onPressed: () {}, child: Text("HOME SCREEN")),
            Expanded(
              child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('users')
                    .where('type', isEqualTo: 'guardian')
                    .where('child_email',
                        isEqualTo: FirebaseAuth.instance.currentUser!.email)
                    .snapshots(),
                // initialData: initialData,
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (!snapshot.hasData) {
                    return Text("...");
                  }
                  return ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (BuildContext context, int index) {
                      final d = snapshot.data!.docs[index];
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          height: 70,
                          color: Color.fromARGB(255, 250, 163, 192),
                          child: ListTile(
                            title: Text(
                              snapshot.data!.docs[index]['name'],
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                              ),
                            ),
                            trailing: IconButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => ChatScreen(
                                          currentUserId: FirebaseAuth
                                              .instance.currentUser!.uid,
                                          friendId: d['uid'],
                                          friendName: d['name'],
                                          // friendImage:
                                          //     'https://www.freepnglogos.com/uploads/google-logo-png/google-logo-png-webinar-optimizing-for-success-google-business-webinar-13.png',
                                        ),
                                      ));
                                },
                                icon: Icon(
                                  Icons.chat,
                                  color: Colors.white,
                                )),
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
