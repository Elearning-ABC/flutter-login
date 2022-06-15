import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../services/firebase_auth_methods.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              backgroundImage: Image.network(context
                          .watch<FirebaseAuthMethods>()
                          .userDetail
                          ?.photoURL ??
                      "https://cdn-icons-png.flaticon.com/512/149/149071.png")
                  .image,
              radius: 50,
            ),
            Text(context.watch<FirebaseAuthMethods>().userDetail?.username ??
                ""),
            Text(context.watch<FirebaseAuthMethods>().userDetail?.email ?? ""),
            ElevatedButton(
              child: const Text("Sign out"),
              onPressed: () {
                context.read<FirebaseAuthMethods>().signOut(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}


