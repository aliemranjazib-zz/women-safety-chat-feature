import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:women_safety_fyp/chat_module/select_screen.dart';
import 'package:women_safety_fyp/screens/rating/user_view_rating.dart';
import 'package:women_safety_fyp/screens/user_Screen/add_contacts.dart';
import 'package:women_safety_fyp/screens/user_Screen/user_dashboard.dart';
import 'package:women_safety_fyp/screens/user_Screen/user_eadit_profile.dart';

class BottomPage extends StatefulWidget {
  const BottomPage({Key? key}) : super(key: key);

  @override
  State<BottomPage> createState() => _BottomPageState();
}

class _BottomPageState extends State<BottomPage> {
  int length = 0;

  void cartItemsLength() {
    FirebaseFirestore.instance.collection('cart').get().then((snap) {
      if (snap.docs.isNotEmpty) {
        setState(() {
          length = snap.docs.length;
        });
      } else {
        setState(() {
          length = 0;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    cartItemsLength();
    return CupertinoTabScaffold(
        tabBar: CupertinoTabBar(items: [
          BottomNavigationBarItem(icon: Icon(Icons.home)),
          BottomNavigationBarItem(icon: Icon(Icons.chat)),
          BottomNavigationBarItem(icon: Icon(Icons.contact_phone)),
          BottomNavigationBarItem(icon: Icon(Icons.person)),
          BottomNavigationBarItem(icon: Icon(Icons.rate_review_outlined)),
        ]),
        tabBuilder: (context, index) {
          switch (index) {
            case 0:
              return CupertinoTabView(builder: ((context) {
                return CupertinoPageScaffold(child: Home());
              }));
            case 1:
              return CupertinoTabView(builder: ((context) {
                return CupertinoPageScaffold(child: SelectScreen());
              }));
            case 2:
              return CupertinoTabView(builder: ((context) {
                return CupertinoPageScaffold(child: AddContacts());
              }));
            case 3:
              return CupertinoTabView(builder: ((context) {
                return CupertinoPageScaffold(child: UserEditProfile());
              }));
            case 4:
              return CupertinoTabView(builder: ((context) {
                return CupertinoPageScaffold(child: USerViewRating());
              }));

            default:
          }
          return Home();
        });
  }
}
