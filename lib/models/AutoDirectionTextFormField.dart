import 'package:flutter/material.dart';
import 'package:note_filest1/models/styles.dart';

import 'AutoDirection.dart';

class AutoDirectionTextFormField extends StatefulWidget {
  final TextEditingController controller;
  final Map<String, String> locale;
  final String errMessage;
  final String hintText;
  final bool isUnderLinedBorder;
  final maxLines;

  const AutoDirectionTextFormField(
      {super.key,
      required this.controller,
      required this.locale,
      required this.errMessage,
      required this.hintText,
      this.isUnderLinedBorder = true,
      this.maxLines = 1});

  @override
  State<AutoDirectionTextFormField> createState() =>
      _AutoDirectionTextFormFieldState();
}

class _AutoDirectionTextFormFieldState
    extends State<AutoDirectionTextFormField> {
  @override
  Widget build(BuildContext context) {
    return AutoDirection(
      text: widget.controller.text != ''
          ? widget.controller.text[0]
          : widget.controller.text,
      child: TextFormField(
        maxLines: widget.maxLines,
        controller: widget.controller,
        onChanged: (value) {
          setState(() {});
        },
        validator: (value) {
          if (value == null || value.isEmpty) {
            return widget.locale[widget.errMessage]!;
          }
          return null;
        },
        decoration: InputDecoration(
            hintText: widget.locale[widget.hintText]!,
            border: widget.isUnderLinedBorder ? null : InputBorder.none),
        style: const MediumText(),
      ),
    );
  }
}
