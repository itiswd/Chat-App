// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:himochat/widgets/constant.dart';

void snackBar(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: primaryColor,
      content: Center(
        child: Text(
          message,
          style: const TextStyle(
            color: Colors.black,
          ),
        ),
      ),
    ),
  );
}
