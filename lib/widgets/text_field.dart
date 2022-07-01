import 'package:flutter/material.dart';


class CustomTextField extends StatelessWidget {
   String? hintText;
  TextEditingController? controller;
  String? Function(String?)? validate;
  Widget? icon;
  bool isPassowrd;
  bool check;
  int? maxLines;
  final TextInputAction? inputAction;
  final FocusNode? focusNode;
    CustomTextField({
    this.hintText,
    this.controller,
    this.validate,
    this.maxLines,
    this.icon,
    this.check = false,
    this.inputAction,
    this.focusNode,
    this.isPassowrd = false,
  });


 bool visible = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 17, vertical: 7),
      child: TextFormField(
        maxLines: maxLines??1,
        focusNode: focusNode,
        textInputAction: inputAction,
        controller: controller,
        obscureText: isPassowrd == false ? false : isPassowrd,
        validator: validate,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          hintText: hintText ?? 'hint Text...',
          suffixIcon: icon,
          contentPadding: const EdgeInsets.all(10),
        ),
      ),
    );
  }
}

