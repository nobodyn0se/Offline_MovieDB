import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:movies_database/providers/logInProvider.dart';
import 'package:provider/provider.dart';

class SignInScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backwardsCompatibility: false,
        systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: Colors.black,
            statusBarIconBrightness: Brightness.light),
        backgroundColor: Colors.black,
        brightness: Brightness.dark,
        centerTitle: true,
        elevation: 0,
        title: Text(
          'Get Started',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Column(
        children: [
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.only(left: 10),
            child: Row(
              children: [
                Icon(
                  Icons.movie_creation,
                  color: Colors.white,
                  size: 48,
                ),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Text(
                    'Offline Movies Watchlist',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 28,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Spacer(
            flex: 3,
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Text(
              'Sign in with your Google Account to create or edit your watchlist',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18),
            ),
          ),
          Spacer(
            flex: 5,
          ),
        ],
      ),
    );
  }
}
