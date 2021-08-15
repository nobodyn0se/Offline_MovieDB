import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LogInProvider extends ChangeNotifier {
  final logIn = GoogleSignIn();

  bool _bufferStatus = false;
  bool get isLoading => _bufferStatus;

  set isLoading(bool val) {
    _bufferStatus = val;
    notifyListeners();
  }

  logUser() async {
    isLoading = true;

    final user = await logIn.signIn();

    if (user == null) {
      isLoading = false;
      return;
    } else {
      final auth = await user.authentication;

      final creds = GoogleAuthProvider.credential(
          accessToken: auth.accessToken, idToken: auth.idToken);

      await FirebaseAuth.instance.signInWithCredential(creds);

      isLoading = false;
    }
  }

  logOut() async {
    await logIn.signOut();
    FirebaseAuth.instance.signOut();
  }
}
