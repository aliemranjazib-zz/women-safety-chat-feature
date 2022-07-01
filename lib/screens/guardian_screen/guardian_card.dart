// ignore_for_file: prefer_const_constructors, prefer_const_constructors_in_immutables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:women_safety_fyp/screens/guardian_screen/guardian_info_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../chat_module/chat_screen.dart';
import '../../utils/styles.dart';
import 'guardian_consultation_names_list.dart';

class DoctorCard extends StatelessWidget {
  const DoctorCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 200.0,
      child: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('users')
              .where('type', isEqualTo: 'doctor')
              .limit(10)
              .snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            final d = snapshot.data!;
            return ListView.builder(
              itemCount: d.docs.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                // var doctor1 = doctorlist[index];
                return InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ChatScreen(
                            currentUserId:
                                FirebaseAuth.instance.currentUser!.uid,
                            friendId: d.docs[index].id,
                            friendName: d.docs[index]['name'],
                            // friendImage:
                            //     'https://www.freepnglogos.com/uploads/google-logo-png/google-logo-png-webinar-optimizing-for-success-google-business-webinar-13.png',
                          ),
                        ));
                  },
                  child: Card(
                    margin: EdgeInsets.only(left: 18.0, bottom: 2.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    child: Container(
                      width: 150.0,
                      padding: EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Expanded(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(14.0),
                              child: Image.network(
                                  'https://cdn.pixabay.com/photo/2020/08/03/09/43/medical-5459654_960_720.png'),
                              // child: Image.asset(
                              //   "${doctor.image}",
                              //   fit: BoxFit.cover,
                              // ),
                            ),
                          ),
                          const SizedBox(
                            height: 12.0,
                          ),
                          Text(
                            "${d.docs[index]['name']}",
                            overflow: TextOverflow.clip,
                            maxLines: 1,
                            textAlign: TextAlign.center,
                            style: ktitlestyle.copyWith(fontSize: 16.0),
                          ),
                          const SizedBox(
                            height: 6.0,
                          ),
                          Text(
                            "${d.docs[index]['specialization']}",
                            overflow: TextOverflow.clip,
                            maxLines: 1,
                            textAlign: TextAlign.center,
                            style: ktitlestyle.copyWith(fontSize: 10.0),
                          )
                        ],
                      ),
                    ),
                  ),
                );
              },
              physics: const BouncingScrollPhysics(),
              shrinkWrap: true,
            );
          }),
    );
  }
}


// class DoctorCard extends StatelessWidget {
//   final List? doctor;
//   // ignore: use_key_in_widget_constructors
//   DoctorCard({required this.doctor});

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       margin: EdgeInsets.only(left: 18.0, bottom: 2.0),
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(12.0),
//       ),
//       child: Container(
//         width: 150.0,
//         padding: EdgeInsets.all(8.0),
//         child: Column(
//           children: [
//             Expanded(
//               child: ClipRRect(
//                 borderRadius: BorderRadius.circular(14.0),
//                 child: Image.network('https://cdn.pixabay.com/photo/2020/08/03/09/43/medical-5459654_960_720.png'),
//                 // child: Image.asset(
//                 //   "${doctor.image}",
//                 //   fit: BoxFit.cover,
//                 // ),
//               ),
//             ),
//             const SizedBox(
//               height: 12.0,
//             ),
//             Text(
//               "${doctor.name}",
//               overflow: TextOverflow.clip,
//               maxLines: 1,
//               textAlign: TextAlign.center,
//               style: ktitlestyle.copyWith(fontSize: 16.0),
//             ),
//             const SizedBox(
//               height: 6.0,
//             ),
//             Text(
//               "${doctor.specialist}",
//               overflow: TextOverflow.clip,
//               maxLines: 1,
//               textAlign: TextAlign.center,
//               style: ktitlestyle.copyWith(fontSize: 10.0),
//             )
//           ],
//         ),
//       ),
//     );
  
  
//   }
// }
