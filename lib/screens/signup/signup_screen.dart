import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../reusable/reusable_func.dart';
import '../../reusable/reusable_widget.dart';
import '../../services/firebase_auth_methods.dart';
import '../../utils/color_utils.dart';
import 'component/signup_field.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _userController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          "Sign up",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              hexStringToColor("CB2B93"),
              hexStringToColor("9546C4"),
              hexStringToColor("5E61F4"),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 120, 20, 0),
            child: Column(
              children: [
                signUpField(
                  _userController,
                  _emailController,
                  _passwordController,
                  _confirmPasswordController,
                ),
                signInSignUpButton(
                  context,
                  false,
                  checkSignUpWithEmail,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void checkSignUpWithEmail() {
    var username = _userController.text.trim();
    var email = _emailController.text.trim();
    var password = _passwordController.text.trim();
    var confirmPassword = _confirmPasswordController.text.trim();
    if (username.isEmpty ||
        email.isEmpty ||
        password.isEmpty ||
        confirmPassword.isEmpty) {
      showMySnackBar(context, "Please fill all fields!");
    } else if (password != confirmPassword) {
      showMySnackBar(context, "Please fill the same password!");
    } else {
      context.read<FirebaseAuthMethods>().signUpWithEmail(
          username: username,
          email: email,
          password: password,
          context: context);
    }
  }
}
