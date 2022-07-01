import 'package:background_sms/background_sms.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:women_safety_fyp/checking.dart';
import 'package:women_safety_fyp/services/share_preff.dart';
// import 'package:women_safety_fyp/landing_screen.dart';
// import 'package:women_safety_fyp/screens/chats/background_sms.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await Geolocator.requestPermission();
  await MyPrefferenc.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Women Safety',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: CheckingScreen(),
    );
  }
}
