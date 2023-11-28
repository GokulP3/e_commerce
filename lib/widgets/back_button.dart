import 'package:flutter/material.dart';

class MyBackButton extends StatelessWidget {
  final Color? iconColor;

  const MyBackButton({Key? key, this.iconColor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        icon: Icon(
          Icons.arrow_back_ios_new_sharp,
          size: 20,
          color: iconColor,
        ));
  }
}
