import 'package:flutter/material.dart';

void showMySnackBar(BuildContext context, String text) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(text)));
}

void showMyDialog(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return Dialog(
        child: SizedBox(
          height: 80,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: const [
              SizedBox(width: 20,),
              CircularProgressIndicator(),
              SizedBox(width: 20,),
              Text("Loading..."),
            ],
          ),
        ),
      );
    },
  );
}