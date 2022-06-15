import 'package:flutter/material.dart';

import '../../../reusable/reusable_widget.dart';

Column signUpField(
  TextEditingController userController,
  TextEditingController emailController,
  TextEditingController passwordController,
  TextEditingController confirmPasswordController,
) {
  return Column(
    children: [
      const SizedBox(
        height: 20,
      ),
      reusableTextField(
        "Enter username",
        Icons.person_outline,
        false,
        userController,
      ),
      const SizedBox(
        height: 20,
      ),
      reusableTextField(
        "Enter email",
        Icons.email_outlined,
        false,
        emailController,
      ),
      const SizedBox(
        height: 20,
      ),
      reusableTextField(
        "Enter password",
        Icons.key_outlined,
        true,
        passwordController,
      ),
      const SizedBox(
        height: 20,
      ),
      reusableTextField(
        "Confirm password",
        Icons.key_outlined,
        true,
        confirmPasswordController,
      ),
      const SizedBox(
        height: 20,
      ),
    ],
  );
}
