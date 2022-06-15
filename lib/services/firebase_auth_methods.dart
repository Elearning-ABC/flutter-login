import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../models/user_detail.dart';
import '../reusable/reusable_func.dart';
import '../screens/home_screen.dart';
import '../screens/signin/signin_screen.dart';
import '../screens/verify_screen.dart';

class FirebaseAuthMethods {
  final FirebaseAuth _auth;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  UserDetail? userDetail;

  FirebaseAuthMethods(this._auth);

  User get user => _auth.currentUser!;

  // EMAIL SIGN IN
  void signInWithEmail(
      {required String email,
      required String password,
      required BuildContext context}) {
    showMyDialog(context);
    _auth
        .signInWithEmailAndPassword(email: email, password: password)
        .then((value) {
      // var currUser = _auth.currentUser;
      userDetail = UserDetail(
        username: user.displayName ?? "",
        email: user.email ?? "",
        photoURL: user.photoURL ?? "",
      );
      Navigator.pop(context);
      if (user.emailVerified) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const HomeScreen(),
          ),
        );
        showMySnackBar(context, "Sign in successfully!");
      } else {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const VerifyScreen(),
          ),
        );
      }
    }).onError((error, stackTrace) {
      Navigator.pop(context);
      showMySnackBar(context, "Error: ${error.toString()}");
    });
  }

  // EMAIL SIGN UP
  void signUpWithEmail(
      {required String username,
      required String email,
      required String password,
      required BuildContext context}) {
    showMyDialog(context);
    _auth
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) async {
      // var currUser = _auth.currentUser;
      await user.updateDisplayName(username);
      await user.updatePhotoURL(
          "https://cdn-icons-png.flaticon.com/512/149/149071.png");
      userDetail = UserDetail(
        username: user.displayName ?? "",
        email: user.email ?? "",
        photoURL: user.photoURL ?? "",
      );
      Navigator.pop(context);
      showMySnackBar(context, "Sign up successfully!");
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const VerifyScreen(),
        ),
      );
    }).onError((error, stackTrace) {
      Navigator.pop(context);
      showMySnackBar(context, "Error: ${error.toString()}");
    });
  }

  // EMAIL VERIFICATION
  Future<void> sendEmailVerification(BuildContext context) async {
    try {
      _auth.currentUser!.sendEmailVerification();
      showMySnackBar(context, 'Email verification sent!');
    } on FirebaseAuthException catch (e) {
      showMySnackBar(context, e.message!); // Display error message
    }
  }

  // GOOGLE SIGN IN
  Future<void> signInWithGoogle(BuildContext context) async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      userDetail = UserDetail(
        username: googleUser?.displayName ?? "",
        email: googleUser?.email ?? "",
        photoURL: googleUser?.photoUrl ?? "",
      );

      if (googleAuth?.accessToken != null && googleAuth?.idToken != null) {
        // Create a new credential
        final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth?.accessToken,
          idToken: googleAuth?.idToken,
        );
        UserCredential userCredential =
            await _auth.signInWithCredential(credential);


        if (user.emailVerified) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const HomeScreen(),
            ),
          );
          showMySnackBar(context, "Sign in successfully!");
        } else {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const VerifyScreen(),
            ),
          );
        }

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const HomeScreen(),
          ),
        );

      }
    } on FirebaseAuthException catch (e) {
      showMySnackBar(context, "Error: ${e.message}");
    }
  }

  // SIGN OUT
  Future<void> signOut(BuildContext context) async {
    try {
      await _googleSignIn.signOut();
      await _auth.signOut();
      userDetail = null;
      showMySnackBar(context, "Signed out!");
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const SignInScreen(),
        ),
      );
    } on FirebaseAuthException catch (e) {
      showMySnackBar(
          context, "Error: ${e.message}"); // Displaying the error message
    }
  }
}
