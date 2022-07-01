import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:women_safety_fyp/screens/user_Screen/user_login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../services/firebase_services.dart';
import '../../utils/styles.dart';
import '../../widgets/eco_button.dart';
import '../../widgets/ecotextfield.dart';

class PatientSignupScreen extends StatefulWidget {
  @override
  State<PatientSignupScreen> createState() => _PatientSignupScreenState();
}

class _PatientSignupScreenState extends State<PatientSignupScreen> {
  // const PatientSignupScreen({Key? key}) : super(key: key);
  TextEditingController emailC = TextEditingController();
  TextEditingController guardianC = TextEditingController();

  TextEditingController nameC = TextEditingController();

  TextEditingController passwordC = TextEditingController();
  TextEditingController phoneC = TextEditingController();

  TextEditingController retypepasswordC = TextEditingController();
  FocusNode? passwordfocus;
  FocusNode? retypepasswordfocus;
  final formkey = GlobalKey<FormState>();
  FirebaseAuth _auth = FirebaseAuth.instance;

  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  bool ispassword = true;
  bool isretypepassword = true;
  bool formStateLoading = false;
  @override
  void dispose() {
    emailC.dispose();
    passwordC.dispose();
    retypepasswordC.dispose();
    super.dispose();
  }

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

  submit() async {
    if (formkey.currentState!.validate()) {
      setState(() {
        formStateLoading = true;
      });
      if (passwordC.text == retypepasswordC.text) {
        String? accountstatus =
            await FirebaseServices.createAccount(emailC.text, passwordC.text);

        await _firestore.collection('users').doc(_auth.currentUser!.uid).set({
          "name": nameC.text,
          "email": emailC.text,
          "guardian_email": guardianC.text,
          "status": false,
          'userphone': phoneC.text,
          'mode': 'open',
          'access': 'allow',
          "type": "user",
          "uid": _auth.currentUser!.uid,
        });
        if (accountstatus != null) {
          ecoDialogue(accountstatus);
          setState(() {
            formStateLoading = false;
          });
        } else {
          Navigator.pop(context);
        }

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => UserLogin(),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
            width: double.infinity,
            child: Column(
              //mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SizedBox(
                  height: 40,
                ),
                const Text(
                  "User Signup",
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
                SizedBox(
                  height: 20,
                ),

                Column(
                  children: [
                    SingleChildScrollView(
                      child: Form(
                          key: formkey,
                          child: Column(
                            children: [
                              EcoTextField(
                                check: true,
                                validate: (v) {
                                  if (v!.isEmpty) {
                                    return "Name is emphty";
                                  }
                                  return null;
                                },
                                inputAction: TextInputAction.next,
                                isPassowrd: false,
                                controller: nameC,
                                hintText: "Name...",
                                icon: const Icon(
                                  Icons.email,
                                  color: Color.fromARGB(255, 255, 134, 174),
                                ),
                              ),
                              EcoTextField(
                                check: true,
                                validate: (v) {
                                  if (v!.isEmpty) {
                                    return "phone is emphty";
                                  }
                                  return null;
                                },
                                inputAction: TextInputAction.next,
                                isPassowrd: false,
                                controller: phoneC,
                                hintText: "Phone...",
                                icon: const Icon(
                                  Icons.phone,
                                  color: Color.fromARGB(255, 255, 134, 174),
                                ),
                              ),
                              EcoTextField(
                                check: true,
                                validate: (v) {
                                  if (!v!.contains("@gmail.com") &&
                                      v.length < 0) {
                                    return "email is badly formated";
                                  }
                                  return null;
                                },
                                inputAction: TextInputAction.next,
                                isPassowrd: false,
                                controller: emailC,
                                hintText: "Email...",
                                icon: const Icon(
                                  Icons.email,
                                  color: Color.fromARGB(255, 255, 134, 174),
                                ),
                              ),
                              EcoTextField(
                                check: true,
                                validate: (v) {
                                  if (!v!.contains("@gmail.com") &&
                                      v.length < 0) {
                                    return "email is badly formated";
                                  }
                                  return null;
                                },
                                inputAction: TextInputAction.next,
                                isPassowrd: false,
                                controller: guardianC,
                                hintText: "Guardian Email...",
                                icon: const Icon(
                                  Icons.email,
                                  color: Color.fromARGB(255, 255, 134, 174),
                                ),
                              ),
                              EcoTextField(
                                validate: (v) {
                                  if (v!.isEmpty) {
                                    return "password should not be empty";
                                  }
                                  return null;
                                },
                                focusNode: passwordfocus,
                                inputAction: TextInputAction.next,
                                isPassowrd: ispassword,
                                controller: passwordC,
                                hintText: "Password...",
                                icon: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      ispassword = !ispassword;
                                    });
                                  },
                                  icon: ispassword
                                      ? const Icon(
                                          Icons.visibility,
                                          color: Color.fromARGB(
                                              255, 255, 134, 174),
                                        )
                                      : const Icon(
                                          Icons.visibility_off,
                                          color: Color.fromARGB(
                                              255, 255, 134, 174),
                                        ),
                                ),
                              ),
                              EcoTextField(
                                isPassowrd: isretypepassword,
                                controller: retypepasswordC,
                                validate: (v) {
                                  if (v!.isEmpty) {
                                    return "password should not be empty";
                                  }
                                  return null;
                                },
                                hintText: "Retype Password...",
                                icon: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      isretypepassword = !isretypepassword;
                                    });
                                  },
                                  icon: isretypepassword
                                      ? const Icon(
                                          Icons.visibility,
                                          color: Color.fromARGB(
                                              255, 255, 134, 174),
                                        )
                                      : const Icon(
                                          Icons.visibility_off,
                                          color: Color.fromARGB(
                                              255, 255, 134, 174),
                                        ),
                                ),
                              ),
                              EcoButton(
                                title: "SIGNUP",
                                isLoginButton: true,
                                onPress: () {
                                  submit();
                                },
                                isLoading: formStateLoading,
                              ),
                            ],
                          )),
                    ),
                  ],
                ),
                // const SizedBox(height: 50),
                EcoButton(
                  title: "BACK TO LOGIN",
                  onPress: () {
                    Navigator.pop(context);
                  },
                  isLoginButton: false,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
