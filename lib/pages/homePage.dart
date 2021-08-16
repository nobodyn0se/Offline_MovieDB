import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:movies_database/providers/logInProvider.dart';
import 'package:movies_database/screens/mainScreen.dart';
import 'package:movies_database/screens/signInScreen.dart';
import 'package:provider/provider.dart';

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseAuth.instance
          .authStateChanges(), //persists signIn unless logged out manually
      builder: (context, snapshot) {
        final prov = Provider.of<LogInProvider>(context, listen: false);
        if (prov.isLoading) {
          return Scaffold(
            backgroundColor: Colors.white,
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else if (snapshot.hasData) {
          return MainScreen();
        } else {
          return SignInScreen();
        }
      },
    );
  }
}
