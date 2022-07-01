import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:women_safety_fyp/screens/admin/admin_main_screen.dart';
import '../../../widgets/ecotextfield.dart';
import '../../utils/styles.dart';
import '../../widgets/eco_button.dart';

class AdminLoginScreen extends StatefulWidget {
  static const String id = "adminlogin";

  const AdminLoginScreen({Key? key}) : super(key: key);
  @override
  State<AdminLoginScreen> createState() => _AdminLoginScreenState();
}

class _AdminLoginScreenState extends State<AdminLoginScreen> {
  FirebaseAuth auth = FirebaseAuth.instance;

  TextEditingController emailC = TextEditingController();
  TextEditingController passwordC = TextEditingController();

  final formkey = GlobalKey<FormState>();
  bool formStateLoading = false;
  final String username = "admin";
  final String Password = "12345";

  submit(BuildContext context) async {
    if (formkey.currentState!.validate()) {
      if (emailC.text == username && passwordC.text == Password) {
        Navigator.push(
            context, MaterialPageRoute(builder: (_) => AdminMainScreen()));
      }

      setState(() {
        formStateLoading = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        // ignore: sized_box_for_whitespace
        child: Container(
          width: double.infinity,
          child: ListView(
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.all(30.0),
                child: const Text(
                  "Admin Login",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color.fromARGB(255, 255, 117, 163),
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
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
                        "https://library.kissclipart.com/20180903/xrw/kissclipart-profile-icon-pink-clipart-computer-icons-user-prof-7c23a79c0e6c539f.png"),
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
                            hintText: "user name...",
                            validate: (v) {
                              //   if (v!.isEmpty) {
                              //     return "email is badly formated";
                              //   }
                              //   return null;
                              // },
                            }),
                        EcoTextField(
                          controller: passwordC,
                          hintText: "Password...",
                          validate: (v) {
                            if (v!.isEmpty) {
                              return "user name should not be empty";
                            }
                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        EcoButton(
                          isLoginButton: true,
                          title: "LogIn",
                          isLoading: formStateLoading,
                          onPress: () {
                            submit(context);
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
