import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:women_safety_fyp/widgets/eco_button.dart';
import 'package:women_safety_fyp/widgets/in_app_webview.dart';
import 'package:flutter/material.dart';

class AdminViewUserRecord extends StatefulWidget {
  const AdminViewUserRecord({Key? key}) : super(key: key);

  @override
  State<AdminViewUserRecord> createState() => _AdminViewUserRecordState();
}

class _AdminViewUserRecordState extends State<AdminViewUserRecord> {
  getAllDoctors() async {
    await FirebaseFirestore.instance
        .collection('users')
        .where('type', isEqualTo: 'user')
        .get()
        .then((value) {});
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Color.fromARGB(255, 248, 133, 172),
          title: Text("User Record"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('users')
                .where('type', isEqualTo: 'user')
                .snapshots(),
            // initialData: initialData,
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) {
                return Center(child: Text('loading...'));
              }
              return Container(
                child: ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (BuildContext context, int index) {
                    final res = snapshot.data!.docs[index];
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(6),
                              border: Border.all(
                                  color: Color.fromARGB(255, 241, 174, 196))),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Align(
                                    alignment: Alignment.center,
                                    child: Text(
                                      "${res['name']}",
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    )),
                                Divider(),
                                Text("name : ${res['name']}"),
                                Text("email : ${res['email']}"),
                                Text(
                                    "guardian_email : ${res['guardian_email']}"),
                                Text("phone ${res['userphone']}"),
                                SwitchListTile(
                                  value: res['status'],
                                  onChanged: (value) {
                                    setState(() {
                                      // res['status'] != res['status'];
                                      if (res['status'] == false) {
                                        FirebaseFirestore.instance
                                            .collection('users')
                                            .doc(res.id)
                                            .update({'status': true});
                                      } else {
                                        FirebaseFirestore.instance
                                            .collection('users')
                                            .doc(res.id)
                                            .update({'status': false});
                                      }
                                    });
                                  },
                                  title: Text("Delete user"),
                                ),
                              ],
                            ),
                          )),
                    );
                  },
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
