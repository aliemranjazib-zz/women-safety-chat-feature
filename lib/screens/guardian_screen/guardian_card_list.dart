// ignore_for_file: prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';

import '../../utils/styles.dart';

class SpecialistCard extends StatelessWidget {
  final String? name;
  final String? doctor;
  // final String? image;
  final Color? color;

  // ignore: use_key_in_widget_constructors
  SpecialistCard({this.name, this.doctor, this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 110.0,
      margin: const EdgeInsets.only(left: 18.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(13.0),
        color: color,
      ),
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Image.asset(
          //   image!,
          //   width: 45.0,
          //   color: Colors.white,
          //   ),
          const SizedBox(
            height: 12.0,
          ),
          Text(
            name!,
            textAlign: TextAlign.center,
            style: ktitlestyle.copyWith(color: Colors.white, height: 1.0),
          ),
          const SizedBox(
            height: 5.0,
          ),
          Text(
            "$doctor Doctor",
            style: ksubtitlestyle.copyWith(
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
