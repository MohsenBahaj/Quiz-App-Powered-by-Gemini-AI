// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class spacer extends StatelessWidget {
  final double size;
  const spacer({
    Key? key,
    required this.size,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: size,
    );
  }
}
