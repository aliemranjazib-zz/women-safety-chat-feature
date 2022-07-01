import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:women_safety_fyp/screens/guardian_screen/guardian-Login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../services/firebase_services.dart';
import '../../utils/styles.dart';
import '../../widgets/eco_button.dart';
import '../../widgets/ecotextfield.dart';

class DoctorSignupScreen extends StatefulWidget {
  @override
  State<DoctorSignupScreen> createState() => _DoctorSignupScreenState();
}

class _DoctorSignupScreenState extends State<DoctorSignupScreen> {
  // const DoctorSignupScreen({Key? key}) : super(key: key);
  TextEditingController emailC = TextEditingController();
  TextEditingController childemailC = TextEditingController();

  TextEditingController passwordC = TextEditingController();
  TextEditingController retypepasswordC = TextEditingController();
  TextEditingController phoneNumberC = TextEditingController();
  TextEditingController nameC = TextEditingController();
  TextEditingController pmcNumberC = TextEditingController();

  FocusNode? passwordfocus;
  FocusNode? retypepasswordfocus;
  final formkey = GlobalKey<FormState>();
  FirebaseAuth _auth = FirebaseAuth.instance;
  String? selectedValue;

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
        String? accountstatus = await FirebaseServices.createAccountDoctorPanel(
            emailC.text, passwordC.text);

        if (accountstatus != null) {
          ecoDialogue(accountstatus);
          setState(() {
            formStateLoading = false;
          });
        } else {
          await _firestore.collection('users').doc(_auth.currentUser!.uid).set({
            "name": nameC.text,
            "email": emailC.text,
            "child_email": childemailC.text,
            'mode': 'open',
            'access': 'allow',
            "phone": phoneNumberC.text,
            "status": false,
            "type": "guardian",
            "uid": _auth.currentUser!.uid,
          });
          // Navigator.pop(context);
          Navigator.push(context,
              MaterialPageRoute(builder: (_) => GuardianLoginScreen()));
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: SafeArea(
            child: Container(
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SizedBox(
                    height: 30,
                  ),
                  const Text(
                    "Guardian Signup",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 255, 117, 163),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    width: 120.0,
                    height: 120.0,
                    decoration: new BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                          color: Color.fromARGB(255, 248, 201, 217),
                          width: 10.0,
                          style: BorderStyle.solid),
                      image: new DecorationImage(
                        fit: BoxFit.fitHeight,
                        image: NetworkImage(
                            "https://st2.depositphotos.com/3557671/11164/v/950/depositphotos_111644880-stock-illustration-man-avatar-icon-of-vector.jpg"),
                      ),
                    ),
                  ),
                  const SizedBox(
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
                                    if (v!.length < 5) {
                                      return "name is not too short";
                                    }
                                    return null;
                                  },
                                  inputAction: TextInputAction.next,
                                  isPassowrd: false,
                                  controller: nameC,
                                  hintText: "Name...",
                                  icon: const Icon(
                                    Icons.person,
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
                                  controller: childemailC,
                                  hintText: "Child Email...",
                                  icon: const Icon(
                                    Icons.email,
                                    color: Color.fromARGB(255, 255, 134, 174),
                                  ),
                                ),
                                EcoTextField(
                                  validate: (v) {
                                    if (v!.isEmpty || v.length < 6) {
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
                                    if (v!.isEmpty || v.length < 6) {
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
                                EcoTextField(
                                  isPassowrd: false,
                                  controller: phoneNumberC,
                                  validate: (v) {
                                    if (v!.isEmpty || v.length > 11) {
                                      return "Phone Number";
                                    }
                                    return null;
                                  },
                                  hintText: "Phone Number...",
                                  icon: const Icon(
                                    Icons.phone_iphone_rounded,
                                    color: Color.fromARGB(255, 255, 134, 174),
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
      ),
    );
  }
}
