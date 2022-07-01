import 'package:flutter/material.dart';
import 'package:women_safety_fyp/screens/guardian_screen/guardian-Login.dart';
import 'package:women_safety_fyp/screens/user_Screen/user_login_screen.dart';

import '../../widgets/eco_button.dart';
import '../admin/admin_login.dart';

class LandingScren extends StatefulWidget {
  const LandingScren({Key? key}) : super(key: key);
  @override
  State<LandingScren> createState() => _LandingScrenState();
}

class _LandingScrenState extends State<LandingScren> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.fill,
            image: NetworkImage(
              "https://images.pexels.com/photos/2088210/pexels-photo-2088210.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
            ),
          ),
        ),
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(40.0),
              child: Center(
                child: Title(
                  color: Colors.pink,
                  child: Text(
                    "Login With your account",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Colors.pink,
                    ),
                  ),
                ),
              ),
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
            EcoButton(
              title: "Login As User",
              onPress: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (_) => UserLogin()));
              },
            ),
            EcoButton(
              title: "Login As Gurdian",
              onPress: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (_) => GuardianLoginScreen()));
              },
            ),
            EcoButton(
              title: "Login As Admin",
              onPress: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (_) => AdminLoginScreen()));
              },
            ),
          ],
        ),
      ),
    );
  }
}
