import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:women_safety_fyp/screens/dummy_home.dart';
import 'package:women_safety_fyp/screens/user_Screen/homepage.dart';
import 'package:women_safety_fyp/screens/user_Screen/user_dashboard.dart';
import 'package:women_safety_fyp/screens/user_Screen/user_signup_screen.dart';
import 'package:women_safety_fyp/services/share_preff.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../bottom_page.dart';
import '../../services/firebase_services.dart';
import '../../utils/styles.dart';
import '../../widgets/eco_button.dart';
import '../../widgets/ecotextfield.dart';

class UserLogin extends StatefulWidget {
  @override
  State<UserLogin> createState() => _UserLoginState();
}

class _UserLoginState extends State<UserLogin> {
  TextEditingController emailC = TextEditingController();

  TextEditingController passwordC = TextEditingController();
  bool ispassword = true;

  FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Future<void> ecoDialogue(String error) async {
    showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            title: Text(error),
            actions: [
              EcoButton(
                title: 'CLOSE',
                onPress: () {
                  Navigator.pop(context);
                },
              ),
            ],
          );
        });
  }

  getDate() {}

  submit() async {
    if (formkey.currentState!.validate()) {
      setState(() {
        formStateLoading = true;
      });

      try {
        UserCredential userCredential = await _auth.signInWithEmailAndPassword(
            email: emailC.text, password: passwordC.text);

        print("Login Sucessfull");
        _firestore.collection('users').doc(_auth.currentUser!.uid).get().then(
            (value) => userCredential.user!.updateDisplayName(value['name']));
        if (userCredential != null) {
          setState(() {
            formStateLoading = false;
          });
          _firestore
              .collection('users')
              .doc(_auth.currentUser!.uid)
              .get()
              .then((value) {
            if (value['status'] == true) {
              ecoDialogue('user may have been deleted');
            } else {
              Navigator.push(
                  context, MaterialPageRoute(builder: (_) => BottomPage()));
            }
          });
          // Navigator.push(
          //     context, MaterialPageRoute(builder: (_) => BottomPage()));
        }
        return userCredential.user;
      } catch (e) {
        ecoDialogue(e.toString());
        print(e);
        return null;
      }
    }
  }

  final formkey = GlobalKey<FormState>();
  bool formStateLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: double.infinity,
          child: ListView(
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SizedBox(
                height: 40,
              ),
              const Text(
                "User Login",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 255, 117, 163),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                width: 100.0,
                height: 100.0,
                decoration: new BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                      color: Color.fromARGB(255, 253, 237, 242),
                      width: 10.0,
                      style: BorderStyle.solid),
                  image: new DecorationImage(
                    fit: BoxFit.fitHeight,
                    image: NetworkImage(
                        "https://img.myloview.com/stickers/women-protection-rgb-color-icon-protect-girls-against-violence-female-empowerment-women-safety-gender-equality-provide-peace-and-security-isolated-vector-illustration-simple-filled-line-drawing-700-267417018.jpg"),
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Column(
                children: [
                  Form(
                      key: formkey,
                      child: Column(
                        children: [
                          EcoTextField(
                            controller: emailC,
                            icon: Icon(
                              Icons.mail,
                              color: Color.fromARGB(255, 255, 134, 174),
                            ),
                            hintText: "Email...",
                            validate: (v) {
                              if (!v!.contains("@gmail.com") && v.length < 0) {
                                return "email is badly formated";
                              }
                              return null;
                            },
                          ),
                          EcoTextField(
                            controller: passwordC,
                            hintText: "Password...",
                            isPassowrd: ispassword,
                            icon: IconButton(
                              onPressed: () {
                                setState(() {
                                  ispassword = !ispassword;
                                });
                              },
                              icon: ispassword
                                  ? const Icon(
                                      Icons.visibility,
                                      color: Color.fromARGB(255, 255, 134, 174),
                                    )
                                  : const Icon(
                                      Icons.visibility_off,
                                      color: Color.fromARGB(255, 255, 134, 174),
                                    ),
                            ),
                            validate: (v) {
                              if (v!.isEmpty) {
                                return "password should not be empty";
                              }
                              return null;
                            },
                          ),
                          EcoButton(
                            title: "LOGIN",
                            isLoading: formStateLoading,
                            isLoginButton: true,
                            onPress: () {
                              submit();
                            },
                          ),
                        ],
                      )),
                ],
              ),
              EcoButton(
                title: "CREATE NEW ACCOUNT",
                onPress: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (_) => PatientSignupScreen()));
                },
                isLoginButton: false,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
