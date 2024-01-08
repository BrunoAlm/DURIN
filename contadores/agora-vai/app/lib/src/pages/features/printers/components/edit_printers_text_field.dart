import 'package:flutter/material.dart';

class EditPrintersTextField extends StatefulWidget {
  final TextEditingController ct;
  final String text;
  const EditPrintersTextField(
      {super.key, required this.ct, required this.text});

  @override
  State<EditPrintersTextField> createState() => EditPrintersTextFieldState();
}

class EditPrintersTextFieldState extends State<EditPrintersTextField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.ct,
      decoration: InputDecoration(
        labelText: widget.text,
        enabledBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(20))),
        focusedBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(20))),
      ),
    );
  }
}
