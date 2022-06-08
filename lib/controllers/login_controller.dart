import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:login/model/user_details.dart';

class LoginController with ChangeNotifier {
  // object
  final _googleSignIn = GoogleSignIn();
  GoogleSignInAccount? googleSignInAccount;
  UserDetails? userDetails;


  // function for google login
  googleLogin() async {
    googleSignInAccount = await _googleSignIn.signIn();

    // inserting values to our user details model
    userDetails = UserDetails(
      displayName: googleSignInAccount!.displayName,
      email: googleSignInAccount!.email,
      photoURL: googleSignInAccount!.photoUrl,
    );

    // call
    notifyListeners();
  }

  logout() async {
    googleSignInAccount = await _googleSignIn.signOut();

    userDetails = null;
    notifyListeners();
  }
}