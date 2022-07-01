import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:women_safety_fyp/chat_module/message_textfield.dart';
// import 'package:women_safety_fyp/screens/chat_module/message_textfield.dart';
import 'package:women_safety_fyp/screens/chat_module/single_message.dart';
// import 'package:women_safety_fyp/screens/widgets/eco_button.dart';
// import 'package:women_safety_fyp/screens/widgets/ecotextfield.dart';
import 'package:women_safety_fyp/widgets/eco_button.dart';
import 'package:women_safety_fyp/widgets/ecotextfield.dart';

class ChatScreen extends StatefulWidget {
  final String? currentUserId;
  final String? friendId;
  final String? friendName;
  // final String friendImage;

  ChatScreen({
    this.currentUserId,
    this.friendId,
    this.friendName,
    // this.friendImage,
  });

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  String? name;

  TextEditingController genderC = TextEditingController();

  TextEditingController ageC = TextEditingController();

  TextEditingController symptomsC = TextEditingController();

  TextEditingController problemC = TextEditingController();

  TextEditingController timeC = TextEditingController();

  final GlobalKey<FormState> formkey = GlobalKey<FormState>();
  String? stt;
  String? stt2;

  bool hide = false;
  // String? type;
  getStatus() async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(widget.currentUserId)

        // .where('type', isEqualTo: 'doctor')
        .get()
        .then((value) {
      if (value.exists) {
        setState(() {
          // stt = e['mode'];
          stt = value.data()!['mode'];
          // if (stt == 'resolved') {
          //   hide = true;
          // }
          print(stt);
        });
      }

      //totalMsgs = value.docs.length;
    });
  }

  getStatus2() async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(widget.friendId)

        // .where('type', isEqualTo: 'doctor')
        .get()
        .then((value) {
      if (value.exists) {
        setState(() {
          // stt = e['mode'];
          stt2 = value.data()!['mode'];
          // if (stt2 == 'resolved') {
          //   // hide = true;
          // }
          print(stt);
        });
      }

      //totalMsgs = value.docs.length;
    });
  }

  checkStatus() {
    if (stt == 'resolved' && stt2 == "resolved") {
      print("ok $stt");
      setState(() {
        hide = true;
      });
    }
  }

  // getDoctors() async {
  //   await FirebaseFirestore.instance
  //       .collection('users')

  //       // .where('type', isEqualTo: 'doctor')
  //       .get()
  //       .then((value) {
  //     setState(() {
  //       type = value.docs.first['type'];
  //     });

  //     //totalMsgs = value.docs.length;
  //   });
  // }

  @override
  void initState() {
    // getStatus();
    getStatus();
    getStatus2();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // print(FirebaseAuth.instance.currentUser!.displayName);
    checkStatus();

    return Scaffold(
      appBar: AppBar(
        actions: [
          StreamBuilder(
              stream:
                  FirebaseFirestore.instance.collection('users').snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData) {
                  return Text("");
                }
                final e = snapshot.data!.docs;
                return IconButton(
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (c) {
                            return AlertDialog(
                              content: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                      "Current Chat status ${e.first["mode"]}"),
                                  // Text("Change : "),
                                  // Switch(value: , onChanged: onChanged)
                                  !(stt == 'resolved' && stt2 == "resolved")
                                      ? ElevatedButton(
                                          onPressed: () async {
                                            await FirebaseFirestore.instance
                                                .collection('users')
                                                .doc(FirebaseAuth
                                                    .instance.currentUser!.uid)
                                                .update({
                                              'mode': 'resolved'
                                            }).then((value) {
                                              setState(() {
                                                hide = true;
                                              });
                                            });
                                            await FirebaseFirestore.instance
                                                .collection('users')
                                                .doc(widget.friendId)
                                                .update({
                                              'mode': 'resolved'
                                            }).then((value) {
                                              setState(() {
                                                hide = true;
                                              });
                                            });
                                          },
                                          child: Text("change to resolved"))
                                      : Container(),
                                  !(stt == 'resolved' && stt2 == "resolved")
                                      ? Text(
                                          'Note: if you click on "change to resolved" you and patient will be not chat again. however both can see chat,[action can not be reverted]')
                                      : Container(),
                                  // ElevatedButton(
                                  //     style: ButtonStyle(),
                                  //     onPressed: () {},
                                  //     child: Text("Ban this patient")),
                                  // Text(
                                  //     'Note: if you ban user you and patient can not talk and all messages will be deleted'),
                                ],
                              ),
                              actions: [
                                EcoButton(
                                  title: "OK",
                                  onPress: () {
                                    Navigator.pop(context);
                                  },
                                  isLoginButton: true,
                                ),
                                EcoButton(
                                  title: "cancel",
                                  onPress: () {
                                    Navigator.pop(context);
                                  },
                                ),
                              ],
                            );
                          });
                    },
                    icon: Icon(Icons.settings));
              }),
          PopupMenuButton(
              itemBuilder: (context) => [
                    PopupMenuItem(
                      child: Text("chat status : $stt"),
                      value: 1,
                      onTap: () async {
                        await FirebaseFirestore.instance
                            .collection('users')
                            .doc(FirebaseAuth.instance.currentUser!.uid)
                            .update({'mode': 'restricted'});
                        await FirebaseFirestore.instance
                            .collection('users')
                            .doc(widget.friendId)
                            .update({'mode': 'restricted'});
                      },
                    ),
                    PopupMenuItem(
                      onTap: () async {
                        await FirebaseFirestore.instance
                            .collection('users')
                            .doc(FirebaseAuth.instance.currentUser!.uid)
                            .update({'mode': 'restricted'});
                        await FirebaseFirestore.instance
                            .collection('users')
                            .doc(widget.friendId)
                            .update({'mode': 'restricted'});
                      },
                      child: Text("ban patient"),
                      value: 2,
                    ),
                  ])
        ],
        backgroundColor: Colors.teal,
        title: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(80),
              child: Image.asset(
                'images/doc.png',
                height: 40,
              ),
            ),
            SizedBox(
              width: 5,
            ),
            Text(
              widget.friendName!,
              style: TextStyle(
                fontSize: 20,
              ),
            )
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(25),
                  topRight: Radius.circular(25),
                ),
              ),
              child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection("users")
                    .doc(widget.currentUserId)
                    .collection('messages')
                    .doc(widget.friendId)
                    .collection('chats')
                    .orderBy(
                      "date",
                      descending: true,
                    )
                    .snapshots(),
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasData) {
                    if (snapshot.data!.docs.length < 1) {
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Say Hi",
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                TextButton(
                                    onPressed: () {
                                      showDialog(
                                          context: context,
                                          builder: (c) {
                                            return AlertDialog(
                                              title:
                                                  Text("Fill these questions"),
                                              content: SingleChildScrollView(
                                                child: Form(
                                                  key: formkey,
                                                  child: Column(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    children: [
                                                      EcoTextField(
                                                          controller: genderC,
                                                          validate: (v) {
                                                            if (v!.isEmpty) {
                                                              return 'Enter M  or m or F or f';
                                                            }
                                                            return null;
                                                          },
                                                          hintText:
                                                              'Enter Gender only write M or F'),
                                                      EcoTextField(
                                                          keyboard:
                                                              TextInputType
                                                                  .number,
                                                          controller: ageC,
                                                          validate: (v) {
                                                            // int b = int.parse(v!);
                                                            if (v!.isEmpty) {
                                                              return 'enter valid age';
                                                            }
                                                            return null;
                                                          },
                                                          hintText:
                                                              'enter age'),
                                                      EcoTextField(
                                                          controller: symptomsC,
                                                          hintText:
                                                              'enter symptoms '),
                                                      EcoTextField(
                                                          controller: problemC,
                                                          hintText:
                                                              'enter problem description'),
                                                      EcoTextField(
                                                          controller: timeC,
                                                          hintText:
                                                              'time when problem start'),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              actions: [
                                                EcoButton(
                                                  isLoginButton: true,
                                                  title: 'submit',
                                                  onPress: () async {
                                                    if (formkey.currentState!
                                                        .validate()) {
                                                      String msg = " gender : " +
                                                          genderC.text +
                                                          "\n age : " +
                                                          ageC.text +
                                                          "\n symptoms : " +
                                                          symptomsC.text +
                                                          "\n description " +
                                                          problemC.text +
                                                          "\n time : " +
                                                          timeC.text;

                                                      await FirebaseFirestore
                                                          .instance
                                                          .collection('users')
                                                          .doc(widget
                                                              .currentUserId)
                                                          .collection(
                                                              'messages')
                                                          .doc(widget.friendId)
                                                          .collection('chats')
                                                          .add({
                                                        "senderId": widget
                                                            .currentUserId,
                                                        "receiverId":
                                                            widget.friendId,
                                                        "message": msg,
                                                        "type": "text",
                                                        "date": DateTime.now(),
                                                      }).then((value) {
                                                        FirebaseFirestore
                                                            .instance
                                                            .collection('users')
                                                            .doc(widget
                                                                .currentUserId)
                                                            .collection(
                                                                'messages')
                                                            .doc(
                                                                widget.friendId)
                                                            .set({
                                                          'last_msg': msg,
                                                        });
                                                      });

                                                      await FirebaseFirestore
                                                          .instance
                                                          .collection('users')
                                                          .doc(widget.friendId)
                                                          .collection(
                                                              'messages')
                                                          .doc(widget
                                                              .currentUserId)
                                                          .collection("chats")
                                                          .add({
                                                        "senderId": widget
                                                            .currentUserId,
                                                        "receiverId":
                                                            widget.friendId,
                                                        "message": msg,
                                                        "type": "text",
                                                        "date": DateTime.now(),
                                                      }).then((value) {
                                                        FirebaseFirestore
                                                            .instance
                                                            .collection('users')
                                                            .doc(
                                                                widget.friendId)
                                                            .collection(
                                                                'messages')
                                                            .doc(widget
                                                                .currentUserId)
                                                            .set({
                                                          "last_msg": msg
                                                        });
                                                      });
                                                    }
                                                  },
                                                ),
                                              ],
                                            );
                                          });
                                    },
                                    child: Text("Fill out a form first")),
                                Text("[only for patient]"),
                              ],
                            ),
                          ],
                        ),
                      );
                    }
                    return ListView.builder(
                      itemCount: snapshot.data!.docs.length,
                      reverse: true,
                      physics: BouncingScrollPhysics(),
                      itemBuilder: (context, index) {
                        // print(snapshot.data!.docs.first.id);

                        // print(snapshot.data.);
                        // for (var item in snapshot.data!.docs) {
                        //   print(item['type']);
                        // }

                        bool isMe = snapshot.data!.docs[index]['senderId'] ==
                            widget.currentUserId;
                        return Dismissible(
                          key: UniqueKey(),
                          onDismissed: (v) async {
                            await FirebaseFirestore.instance
                                .collection('users')
                                .doc(widget.currentUserId!)
                                .collection('messages')
                                .doc(widget.friendId)
                                .collection('chats')
                                .doc(snapshot.data!.docs[index].id)
                                .delete()
                                .then((value) {
                              // FirebaseFirestore.instance
                              //     .collection('users')
                              //     .doc(widget.currentId)
                              //     .collection('messages')
                              //     .doc(widget.friendId)
                              //     .set({
                              //   'last_msg': message,
                              // });
                            });

                            await FirebaseFirestore.instance
                                .collection('users')
                                .doc(widget.friendId)
                                .collection('messages')
                                .doc(widget.currentUserId!)
                                .collection("chats")
                                .doc(snapshot.data!.docs[index].id)
                                .delete()
                                .then((value) {
                              // FirebaseFirestore.instance
                              //     .collection('users')
                              //     .doc(widget.friendId)
                              //     .collection('messages')
                              //     .doc(widget.currentId)
                              //     .set({"last_msg": message});
                            });
                          },
                          child: SingleMessage(
                            message: snapshot.data!.docs[index]['message'],
                            date: snapshot.data!.docs[index]['date'],
                            isMe: isMe,
                            friendname: widget.friendName,
                            myname:
                                FirebaseAuth.instance.currentUser!.displayName,
                            type: snapshot.data!.docs[index]['type'],
                          ),
                        );
                      },
                    );
                  }
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                },
              ),
            ),
          ),
          MessageTextField(
            widget.currentUserId!,
            widget.friendId!,
            hide,
          ),
        ],
      ),
    );
  }

  Widget messages(Size size, String message, String senderId, String type,
      BuildContext context) {
    return type == "text"
        ? Container(
            width: size.width,
            alignment: senderId == FirebaseAuth.instance.currentUser!.uid
                ? Alignment.centerRight
                : Alignment.centerLeft,
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 14),
              margin: EdgeInsets.symmetric(vertical: 5, horizontal: 8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Colors.blue,
              ),
              child: Text(
                message,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
              ),
            ),
          )
        : Container(
            height: size.height / 2.5,
            width: size.width,
            padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
            alignment: senderId == FirebaseAuth.instance.currentUser!.uid
                ? Alignment.centerRight
                : Alignment.centerLeft,
            child: InkWell(
              onTap: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => ShowImage(
                    imageUrl: message,
                  ),
                ),
              ),
              child: Container(
                height: size.height / 2.5,
                width: size.width / 2,
                decoration: BoxDecoration(border: Border.all()),
                alignment: message != "" ? null : Alignment.center,
                child: message != ""
                    ? Image.network(
                        message,
                        fit: BoxFit.cover,
                      )
                    : CircularProgressIndicator(),
              ),
            ),
          );
  }
}

class ShowImage extends StatelessWidget {
  final String imageUrl;

  const ShowImage({required this.imageUrl, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
        height: size.height,
        width: size.width,
        color: Colors.black,
        child: Image.network(imageUrl),
      ),
    );
  }
}

//