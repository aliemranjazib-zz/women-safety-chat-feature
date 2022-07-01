import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:women_safety_fyp/screens/guardian_screen/guardian_sing-up.dart';
import 'package:women_safety_fyp/screens/guardian_screen/homepage.dart';
import 'package:women_safety_fyp/screens/user_Screen/homepage.dart';
import 'package:women_safety_fyp/screens/user_Screen/user_signup_screen.dart';
import 'package:women_safety_fyp/services/share_preff.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../services/firebase_services.dart';
import '../../utils/styles.dart';
import '../../widgets/eco_button.dart';
import '../../widgets/ecotextfield.dart';

class GuardianLoginScreen extends StatefulWidget {
  const GuardianLoginScreen({Key? key}) : super(key: key);
  @override
  State<GuardianLoginScreen> createState() => _GuardianLoginScreenState();
}

class _GuardianLoginScreenState extends State<GuardianLoginScreen> {
  TextEditingController emailC = TextEditingController();
  TextEditingController passwordC = TextEditingController();
  FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  bool ispassword = true;

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
              MyPrefferenc.saveEmail(emailC.text);
              Navigator.push(context,
                  MaterialPageRoute(builder: (_) => GuardianHomeScreen()));
            }
          });

          // Navigator.push(
          //     context, MaterialPageRoute(builder: (_) => GuardianHomeScreen()));
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
            children: [
              const SizedBox(
                height: 50,
              ),
              const Text(
                "Guardian Login",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 255, 117, 163),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Container(
                width: 150.0,
                height: 150.0,
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
              SizedBox(
                height: 20,
              ),
              Column(
                children: [
                  Form(
                    key: formkey,
                    child: Column(
                      children: [
                        EcoTextField(
                          controller: emailC,
                          hintText: "Email...",
                          icon: Icon(
                            Icons.mail,
                            color: Color.fromARGB(255, 255, 134, 174),
                          ),
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
                              return "pass should not be empty";
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
                    ),
                  ),
                ],
              ),
              EcoButton(
                title: "CREATE NEW ACCOUNT",
                onPress: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => DoctorSignupScreen(),
                    ),
                  );
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
