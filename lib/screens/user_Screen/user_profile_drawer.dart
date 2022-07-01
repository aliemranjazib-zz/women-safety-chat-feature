import 'package:flutter/material.dart';

import '../../utils/styles.dart';

class PatientProfileDrawer extends StatelessWidget {
  IconData? icon;
  String? text;
  PatientProfileDrawer({
    this.icon,
    this.text,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(8.0, 15, 8.0, 0),
        child: Container(
          height: 50,
          decoration: const BoxDecoration(
              border: Border(bottom: BorderSide(color: Colors.grey))),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(icon),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 15.0,
                    ),
                    child: Text(
                      text!,
                      style: ksubtitlestyle,
                    ),
                  ),
                ],
              ),
              const Icon(Icons.arrow_right),
            ],
          ),
        ),
      ),
    );
  }
}
