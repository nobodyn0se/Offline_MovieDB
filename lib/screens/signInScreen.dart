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
          Container(
            height: 150,
            decoration: BoxDecoration(
              color: Colors.black,
              boxShadow: <BoxShadow>[
                BoxShadow(
                  color: Colors.black54,
                  blurRadius: 40,
                ),
              ],
              borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(100),
              ),
            ),
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
          InkWell(
            onTap: () {
              final prov = Provider.of<LogInProvider>(context, listen: false);
              prov.logUser();
            },
            child: Ink(
              color: Color(0xFF397AF3),
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: Wrap(
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    Image.asset(
                      'assets/google_logo.png',
                      height: 50,
                      width: 50,
                      fit: BoxFit.cover,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      'Log In With Google',
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  ],
                ),
              ),
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
