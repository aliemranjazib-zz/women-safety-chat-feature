// import 'package:women_safety_fyp/screens/new_chat/new_chat_screen.dart';
import 'package:women_safety_fyp/chat_module/chat_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../utils/styles.dart';
// import '../chat/patient_chat.dart';
import 'guardian_consultation_names_list.dart';

class GurdianInfo extends StatelessWidget {
  String? Name;
  String? info;
  String? id;
  String? email;
  // String?

  GurdianInfo({
    this.Name,
    this.info,
    this.id,
    this.email,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text("$uid"),
      // ),
      body: Container(
        width: double.infinity,
        height: MediaQuery.of(context).size.height * 0.90,
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage(
                "images/intro_page_doc.jpg",
              ),
              alignment: Alignment.topCenter,
              fit: BoxFit.fitWidth),
        ),
        child: Column(
          children: [
            const SizedBox(
              height: 50,
            ),
            Padding(
              // ignore: prefer_const_constructors
              padding: EdgeInsets.symmetric(horizontal: 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          color: Colors.black,
                        ),
                        child: const Icon(
                          Icons.arrow_back,
                          color: Colors.white,
                        )),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.24,
            ),
            Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Kblack,
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(50),
                ),
              ),
              child: Container(
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.only(
                    top: 30,
                    left: 30,
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            radius: 30,
                            child: ClipOval(
                              child: SizedBox(
                                  width: 100,
                                  height: 100,
                                  child: Image.asset(
                                    "images/doc3.jpg",
                                    fit: BoxFit.cover,
                                  )),
                            ),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          Column(
                            children: [
                              Text(
                                "Doctor $Name",
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                              ),

                              // Text(
                              //   specialization!,
                              //   style: ksubtitlestyle,
                              // ),
                              // Text(specialization!),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            Text(
              "About Doctor",
              style: ktitlestyle,
            ),
            const SizedBox(
              height: 20,
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Text(
                  info!,
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                    color: Kblack.withOpacity(0.9),
                  ),
                ),
              ),
            ),
            Spacer(),
            Center(
              child: InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ChatScreen(
                          currentUserId: FirebaseAuth.instance.currentUser!.uid,
                          friendId: id,
                          friendName: Name,
                          // friendImage:
                          //     'https://www.freepnglogos.com/uploads/google-logo-png/google-logo-png-webinar-optimizing-for-success-google-business-webinar-13.png',
                        ),
                      ));
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      onPressed: () {
                        // Navigator.push(context,MaterialPageRoute(builder: (_)=>  WelcomeScreen()));
                      },
                      icon: Icon(Icons.chat_bubble, color: Colors.blue),
                    ),
                    Row(
                      children: [
                        Text(
                          "Chat with your doctor....",
                          style: ksubtitlestyle,
                        )
                      ],
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
