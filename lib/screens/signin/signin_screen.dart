import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../reusable/reusable_func.dart';
import '../../reusable/reusable_widget.dart';
import '../../services/firebase_auth_methods.dart';
import '../../utils/color_utils.dart';
import 'component/signin_field.dart';
import 'component/signup_option.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            padding: EdgeInsets.fromLTRB(
                20, MediaQuery.of(context).size.height * 0.1, 20, 0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                logoWidget('assets/images/logo.png'),
                loginField(_emailController, _passwordController),
                const SizedBox(
                  height: 10,
                ),
                signInSignUpButton(context, true, checkSignInWithEmail),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.6,
                  child: const Divider(
                    color: Colors.white,
                  ),
                ),
                signInWithOtherMethod(context, "GOOGLE", "000000", "FFFFFF", "assets/images/google.png", () {
                  context.read<FirebaseAuthMethods>().signInWithGoogle(context);
                }),
                signInWithOtherMethod(context, "FACEBOOK", "FFFFFF", "3B64A8", "assets/images/facebook.png", () {}),
                signUpOption(context),
                const SizedBox(height: 20,),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void checkSignInWithEmail() {
    var email = _emailController.text.trim();
    var password = _passwordController.text.trim();
    if (email.isEmpty || password.isEmpty) {
      showMySnackBar(context, "Please fill all fields!");
    } else {
      context.read<FirebaseAuthMethods>().signInWithEmail(email: email, password: password, context: context);
    }
  }


}
