import 'package:flutter/material.dart';

import '../../../reusable/reusable_widget.dart';

Widget loginField(TextEditingController emailController, TextEditingController passwordController) {
  return Column(
    children: [
      const SizedBox(
        height: 30,
      ),
      reusableTextField(
        "Enter email",
        Icons.person_outline,
        false,
        emailController,
      ),
      const SizedBox(
        height: 10,
      ),
      reusableTextField(
        "Enter password",
        Icons.lock_outline,
        true,
        passwordController,
      ),
    ],
  );
}