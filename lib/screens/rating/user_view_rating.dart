// ignore_for_file: deprecated_member_use

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class USerViewRating extends StatefulWidget {
  // const USerViewRating({Key? key}) : super(key: key);

  @override
  State<USerViewRating> createState() => _USerViewRatingState();
}

class _USerViewRatingState extends State<USerViewRating> {
  TextEditingController location = TextEditingController();
  TextEditingController rating = TextEditingController();

  bool isSaving = false;
  final _formKey = GlobalKey<FormState>();
  @override
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Color.fromARGB(255, 248, 133, 172),
          title: Text("Give Rating"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Center(
                child: RaisedButton(
                  color: Color.fromARGB(255, 255, 117, 163),
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            content: Stack(
                              // overflow: Overflow.visible,
                              children: <Widget>[
                                Positioned(
                                  right: -40.0,
                                  top: -40.0,
                                  child: InkResponse(
                                    onTap: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: CircleAvatar(
                                      child: Icon(Icons.close),
                                      backgroundColor: Colors.red,
                                    ),
                                  ),
                                ),
                                Form(
                                  key: _formKey,
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: TextFormField(
                                          controller: location,
                                          decoration: InputDecoration(
                                              hintText: "Enter Location"),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: TextFormField(
                                          controller: rating,
                                          decoration: InputDecoration(
                                              hintText: "Enter Rating"),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: RaisedButton(
                                          color: Color.fromARGB(
                                              255, 248, 136, 173),
                                          child: Text("Submit"),
                                          onPressed: () {
                                            // clearField();
                                            if (_formKey.currentState!
                                                .validate()) {
                                              // _formKey.currentState!.save();
                                              saveme();
                                            }
                                          },
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          );
                        });
                  },
                  child: Text("Press Here to give Your Rating"),
                ),
              ),
              Expanded(
                child: Container(
                  child: StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection("reviews")
                        .snapshots(),
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot> snapshot) {
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
                              height: 70,
                              color: Color.fromARGB(255, 250, 163, 192),
                              child: ListTile(
                                title: Text(
                                  d['title'],
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 20,
                                  ),
                                ),
                                subtitle: Text(
                                  d['detail'],
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  saveme() async {
    setState(() {
      isSaving = true;
    });
    await FirebaseFirestore.instance.collection('reviews').add({
      "title": location.text,
      "detail": rating.text,
    }).whenComplete(() {
      setState(() {
        isSaving = false;

        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text("Succesfully Added")));
      });
    });
  }

  clearField() {
    setState(() {
      location.clear();
      rating.clear();
    });
  }
}
