import 'package:women_safety_fyp/screens/main_show_screens/landing_screen.dart';
import 'package:women_safety_fyp/screens/user_Screen/user_eadit_profile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../screens/user_Screen/user_profile_drawer.dart';

class PatientDrawer extends StatelessWidget {
  const PatientDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Container(
              child: Column(
                children: [
                  Stack(
                    children: [
                      CircleAvatar(
                        radius: 40,
                        child: ClipOval(
                          child: SizedBox(
                            height: 100,
                            width: 100,
                            child: Image.asset("images/doc1.jpg"),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
          InkWell(
            splashColor: Colors.blue,
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (_) => UserEditProfile()));
            },
            child: PatientProfileDrawer(
              icon: Icons.person,
              text: "Profile",
            ),
          ),
          InkWell(
            splashColor: Colors.blue,
            onTap: () {
              // print("cheeck${widget.userid}");
            },
            child: PatientProfileDrawer(
              icon: Icons.settings,
              text: "Settings",
            ),
          ),
          InkWell(
            splashColor: Colors.blue,
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
