// import 'dart:math';

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:women_safety_fyp/screens/main_show_screens/landing_screen.dart';
// import 'package:women_safety_fyp/screens/user_Screen/guardian_detail.dart';
// import 'package:women_safety_fyp/screens/user_Screen/recent_chats.dart';
// import 'package:women_safety_fyp/widgets/custom_drawer.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// // import 'package:google_fonts/google_fonts.dart';
// import 'package:intl/intl.dart';

// import '../../models/chat_model.dart';
// import '../../utils/styles.dart';
// import '../guardian_screen/guardian_card.dart';
// import '../guardian_screen/guardian_card_list.dart';
// import '../guardian_screen/guardian_consulation_card_style.dart';
// import '../guardian_screen/guardian_consultation_names_list.dart';
// import '../guardian_screen/guardian_info_page.dart';
// import '../guardian_screen/homepage.dart';
// import 'user_eadit_profile.dart';
// import 'user_profile_drawer.dart';

// class PatientHomeScreen extends StatefulWidget {
//   Chat? doctorimage;
//   String? userid;
//   PatientHomeScreen({this.doctorimage, this.userid});

//   @override
//   State<PatientHomeScreen> createState() => _PatientHomeScreenState();
// }

// class _PatientHomeScreenState extends State<PatientHomeScreen> {
//   final TextEditingController _search = TextEditingController();
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
//   List allProducts = [];
//   TextEditingController sC = TextEditingController();
//   var map = Map();

//   getDate() async {
//     await FirebaseFirestore.instance
//         .collection("users")
//         .where('type', isEqualTo: 'doctor')
//         .get()
//         .then((QuerySnapshot? snapshot) {
//       snapshot!.docs.forEach((e) {
//         if (e.exists) {
//           setState(() {
//             allProducts.add(
//               e['specialization'],
//             );
//           });
//         }
//       });
//     });

//     allProducts
//         .forEach((x) => map[x] = !map.containsKey(x) ? (1) : (map[x] + 1));

//     print(map);
//     print(allProducts);
//   }

//   @override
//   void initState() {
//     getDate();
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     String? _message;
//     DateTime now = DateTime.now();
//     String _currentHour = DateFormat('kk').format(now);
//     int hour = int.parse(_currentHour);

//     setState(
//       () {
//         if (hour >= 5 && hour < 12) {
//           _message = 'Good Morning';
//         } else if (hour >= 12 && hour <= 17) {
//           _message = 'Good Afternoon';
//         } else {
//           _message = 'Good Evening';
//         }
//       },
//     );
//     return Scaffold(
//       appBar: AppBar(
//         centerTitle: true,
//         title: Text("HOME PAGE"),
//       ),
//       drawer: PatientDrawer(),
//       body: Container(
//           child: SingleChildScrollView(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             const SizedBox(
//               height: 45,
//             ),
//             Container(
//               //width: MediaQuery.of(context).size.width/1.3,
//               alignment: Alignment.center,
//               child: Text(
//                 _message!,
//                 style: TextStyle(
//                   color: Colors.black54,
//                   fontSize: 20,
//                   fontWeight: FontWeight.w400,
//                 ),
//               ),
//             ),
//             const SizedBox(
//               height: 25.0,
//             ),
//             Container(
//               alignment: Alignment.centerLeft,
//               padding: EdgeInsets.only(left: 20, bottom: 10),
//               child: Text(
//                 "Hello ",
//                 style: TextStyle(
//                   fontSize: 18,
//                   fontWeight: FontWeight.w500,
//                 ),
//               ),
//             ),
//             const SizedBox(
//               height: 25.0,
//             ),

//             Container(
//               alignment: Alignment.centerLeft,
//               padding: EdgeInsets.only(left: 20, bottom: 25),
//               child: Text(
//                 "Let's Find Your\nDoctor",
//                 style: TextStyle(
//                   fontSize: 35,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: InkWell(
//                 onTap: () {
//                   Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) => RecentChatScreen(),
//                       ));
//                 },
//                 child: Container(
//                   height: 70,
//                   width: double.infinity,
//                   decoration: BoxDecoration(
//                     color: Colors.amber,
//                     borderRadius: BorderRadius.circular(10),
//                   ),
//                   child: Center(child: Text("FIND YOUR CHATS")),
//                 ),
//               ),
//             ),

//             const Padding(
//               padding: EdgeInsets.symmetric(horizontal: 18.0),
//               child: Text(
//                 "Specialist",
//               ),
//             ),
//             const SizedBox(
//               height: 15,
//             ),
//             // ignore: sized_box_for_whitespace
//             Container(
//                 width: double.infinity,
//                 height: 150.0,
//                 child: ListView(
//                     scrollDirection: Axis.horizontal,
//                     children: map.entries
//                         .map(
//                           (e) => InkWell(
//                             onTap: () {
//                               print(e.key);
//                               Navigator.push(
//                                   context,
//                                   MaterialPageRoute(
//                                       builder: (_) => GuardianDetailScreen(
//                                           speciality: e.key.toString())));
//                             },
//                             child: SpecialistCard(
//                                 name: e.key,
//                                 color: Colors.primaries[Random().nextInt(10)],
//                                 doctor: e.value.toString()),
//                           ),
//                         )
//                         .toList())
//                 // child: ListView.builder(
//                 //   scrollDirection: Axis.horizontal,
//                 //   itemCount: map.length,
//                 //   itemBuilder: (BuildContext context, int index) {
//                 //     return SpecialistCard(
//                 //       name: map.keys.first,
//                 //       color: Colors.red,
//                 //       doctor: "OKKK",
//                 //     );
//                 //   },
//                 // ),
//                 ),
//             const SizedBox(
//               width: double.infinity,
//               height: 25.0,
//             ),
//             Container(
//               width: double.infinity,
//               height: 150.0,
//               child: ListView.builder(
//                   itemCount: consultation.length,
//                   scrollDirection: Axis.horizontal,
//                   shrinkWrap: true,
//                   physics: const BouncingScrollPhysics(),
//                   itemBuilder: (context, index) {
//                     var item = consultation[index];
//                     return ConsultationCard(consultation: item);
//                   }),
//             ),
//             const SizedBox(
//               height: 25.0,
//             ),
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 18.0),
//               child: Row(
//                 children: [
//                   Text(
//                     "Top Doctor",
//                     style: ktitlestyle,
//                   ),
//                   const Spacer(),
//                   InkWell(
//                       onTap: () {
//                         // ignore: prefer_const_constructors
//                         Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                                 builder: (_) => DoctorHomeScreen()));
//                       },
//                       child: Text(
//                         "View all",
//                         style: ksubtitlestyle,
//                       ))
//                 ],
//               ),
//             ),
//             const SizedBox(
//               height: 15.0,
//             ),
//             // ignore: sized_box_for_whitespace
//             // _doctorTile(),
//             DoctorCard(),
//             const SizedBox(
//               width: 25.0,
//             ),
//           ],
//         ),
//       )),
//     );
//   }

//   // Widget _doctorTile() {
//   //   return Container(
//   //       margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
//   //       decoration: BoxDecoration(
//   //         color: Colors.white,
//   //         borderRadius: BorderRadius.all(Radius.circular(20)),
//   //         boxShadow: <BoxShadow>[
//   //           BoxShadow(
//   //             offset: Offset(4, 4),
//   //             blurRadius: 10,
//   //             color: Colors.grey.withOpacity(.2),
//   //           ),
//   //           BoxShadow(
//   //             offset: Offset(-3, 0),
//   //             blurRadius: 15,
//   //             color: Colors.grey.withOpacity(.1),
//   //           )
//   //         ],
//   //       ),
//   //       child: Container(
//   //         padding: EdgeInsets.symmetric(horizontal: 18, vertical: 8),
//   //         child: ListTile(
//   //           contentPadding: EdgeInsets.all(0),
//   //           leading: ClipRRect(
//   //             borderRadius: BorderRadius.all(Radius.circular(13)),
//   //             child: Container(
//   //               height: 55,
//   //               width: 55,
//   //               decoration: BoxDecoration(
//   //                   borderRadius: BorderRadius.circular(15),
//   //                   color: Colors.cyan),
//   //               child: Image.asset(
//   //                 'images/doc.png',
//   //                 height: 50,
//   //                 width: 50,
//   //                 fit: BoxFit.contain,
//   //               ),
//   //             ),
//   //           ),
//   //           title: Text("Name", style: TextStyle()),
//   //           subtitle: Text(
//   //             "type",
//   //             style: TextStyle(),
//   //           ),
//   //           trailing: Icon(
//   //             Icons.keyboard_arrow_right,
//   //             size: 30,
//   //             color: Theme.of(context).primaryColor,
//   //           ),
//   //         ),
//   //       ));

//   // }
// }
