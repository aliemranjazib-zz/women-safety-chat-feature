import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:women_safety_fyp/utils/styles.dart';
import 'package:women_safety_fyp/widgets/eco_button.dart';
import 'package:women_safety_fyp/widgets/ecotextfield.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserEditProfile extends StatefulWidget {
  @override
  State<UserEditProfile> createState() => _UserEditProfileState();
}

class _UserEditProfileState extends State<UserEditProfile> {
  TextEditingController nameC = TextEditingController();
  String? id;
  getName() async {
    await FirebaseFirestore.instance
        .collection('users')
        .where('uid', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then((value) {
      nameC.text = value.docs.first['name'];
      id = value.docs.first.id;
    });
  }

  @override
  void initState() {
    getName();
    super.initState();
  }

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Color.fromARGB(255, 248, 133, 172),
        title: const Text("Profile"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.all(30.0),
                child: Title(
                  color: Colors.black,
                  child: Text(
                    "Update Your Profile here....",
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 255, 117, 163),
                    ),
                  ),
                ),
              ),
              EcoTextField(
                check: true,
                validate: (v) {
                  if (v!.isEmpty) {
                    return "update your name like (user)";
                  }
                  return null;
                },
                inputAction: TextInputAction.next,
                controller: nameC,
                hintText: "Update your name...",
                icon: const Icon(
                  Icons.edit,
                  color: Color.fromARGB(255, 255, 134, 174),
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              EcoButton(
                title: "Update",
                isLoading: false,
                isLoginButton: true,
                onPress: () async {
                  await FirebaseFirestore.instance
                      .collection('users')
                      .doc(id)
                      .update({"name": nameC.text}).whenComplete(() {
                    Get.snackbar(
                      "",
                      "UPDATED",
                    );
                  });
                },
                // onPress: updateprofiledata,
              ),
              EcoButton(
                title: "Logout",
                isLoading: false,
                isLoginButton: true,
                onPress: () {
                  FirebaseAuth.instance.signOut().then((value) {
                    Get.back();
                  });

                  // Navigator.Push
                },
                // onPress: updateprofiledata,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
