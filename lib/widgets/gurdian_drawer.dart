import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:women_safety_fyp/screens/guardian_screen/guardian_profile.dart';
// import 'package:women_safety_fyp/screens/doctor_screen/doctor_profile.dart';
// import 'package:/screens/doctor_screen/doctor_profile.dart';
import 'package:women_safety_fyp/screens/main_show_screens/landing_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
// import 'package:women_safety_fyp/screens/doctor_screen/doctor_profile.dart';

import '../screens/user_Screen/user_profile_drawer.dart';

class GuardianDrawer extends StatefulWidget {
  const GuardianDrawer({Key? key}) : super(key: key);

  @override
  State<GuardianDrawer> createState() => _GuardianDrawerState();
}

class _GuardianDrawerState extends State<GuardianDrawer> {
  getDate() {
    FirebaseFirestore.instance
        .collection('users')
        .where('uid', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then((snapshot) {});
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 248, 133, 172),
            ),
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Gurdian Detail",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                        color: Colors.white),
                  )
                ],
              ),
            ),
          ),
          InkWell(
            splashColor: Colors.pink,
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (_) => GuardianProfile()));
            },
            child: PatientProfileDrawer(
              icon: Icons.person,
              text: "Profile",
            ),
          ),
          InkWell(
            splashColor: Colors.pink,
            onTap: () {
              FirebaseAuth.instance.signOut();
              Navigator.push(
                  context, MaterialPageRoute(builder: (_) => LandingScren()));
            },
            child: PatientProfileDrawer(
              icon: Icons.lock,
              text: "Logout",
            ),
          ),
        ],
      ),
    );
  }
}
