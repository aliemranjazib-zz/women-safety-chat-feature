import 'package:flutter/material.dart';

class EcoTextField extends StatefulWidget {
  String? hintText;
  TextEditingController? controller;
  String? Function(String?)? validate;
  Widget? icon;
  bool isPassowrd;
  bool check;
  int? maxLines;
  TextInputType? keyboard;

  final TextInputAction? inputAction;
  final FocusNode? focusNode;
  EcoTextField({
    this.hintText,
    this.controller,
    this.keyboard,
    this.validate,
    this.maxLines,
    this.icon,
    this.check = false,
    this.inputAction,
    this.focusNode,
    this.isPassowrd = false,
  });

  @override
  State<EcoTextField> createState() => _EcoTextFieldState();
}

class _EcoTextFieldState extends State<EcoTextField> {
  bool visible = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 17, vertical: 7),
      decoration: BoxDecoration(
          color: Colors.grey.withOpacity(0.5),
          borderRadius: BorderRadius.circular(10)),
      child: TextFormField(
        cursorColor: Colors.pink,

        // keyboardType: TextInputType.number,
        // maxLines: widget.maxLines == 1 ? 1 : widget.maxLines,
        focusNode: widget.focusNode,
        keyboardType:
            widget.keyboard == null ? TextInputType.name : widget.keyboard,

        textInputAction: widget.inputAction,
        controller: widget.controller,
        obscureText: widget.isPassowrd == false ? false : widget.isPassowrd,
        validator: widget.validate,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: widget.hintText ?? 'hint Text...',
          suffixIcon: widget.icon,
          iconColor: Color.fromARGB(255, 250, 163, 192),
          fillColor: Color.fromARGB(255, 250, 176, 200),
          contentPadding: const EdgeInsets.all(10),
        ),
      ),
    );
  }
}
