import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../services/firebase_auth_methods.dart';
import 'home_screen.dart';

class VerifyScreen extends StatelessWidget {
  const VerifyScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: SizedBox(
            width: MediaQuery.of(context).size.width*0.9,
            child: Column(
              children: [
                const SizedBox(height: 30,),
                const Text("Please verify your email to continue."),
                const SizedBox(height: 10,),
                ElevatedButton(
                    onPressed: () {
                      context.read<FirebaseAuthMethods>().sendEmailVerification(context);
                    },
                    child: const Text("Send me an verification email"),
                ),
                const SizedBox(height: 10,),
                const Text("If you verified your email, re-login to start"),
                const SizedBox(height: 10,),
                ElevatedButton(
                  onPressed: () {
                    context.read<FirebaseAuthMethods>().signOut(context);
                  },
                  child: const Text("Sign out"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
