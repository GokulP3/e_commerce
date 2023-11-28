import 'package:flutter/material.dart';

class SnackBarWidget {
  snackBar(context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Center(
            child: Text(
          message,
          style: const TextStyle(fontWeight: FontWeight.w300),
        )),
        shape: const StadiumBorder(),
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.all(50),
        duration: const Duration(milliseconds: 2500)));
  }
}
