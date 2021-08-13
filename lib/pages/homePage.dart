import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:movies_database/providers/logInProvider.dart';
import 'package:movies_database/screens/mainScreen.dart';
import 'package:movies_database/screens/signInScreen.dart';
import 'package:provider/provider.dart';

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => LogInProvider(),
      child: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          final prov = Provider.of<LogInProvider>(context);
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
      ),
    );
  }
}
