import 'package:flutter/material.dart';

class NoteTitle extends StatelessWidget {
  const NoteTitle({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: RichText(
          text: TextSpan(
        style: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 30,
            letterSpacing: 5,
            color: Colors.black),
        children: const <TextSpan>[
          TextSpan(text: "NO"),
          TextSpan(
              text: "T", style: TextStyle(color: Colors.deepPurple)),
          TextSpan(text: "ES"),
        ],
      )),
    );
  }
}