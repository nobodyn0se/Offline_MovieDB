import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:movies_database/providers/logInProvider.dart';
import 'package:provider/provider.dart';

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    const String mainTitle = 'Movies Database';
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: Text(
          mainTitle,
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        actions: [
          IconButton(
            onPressed: () {
              final prov = Provider.of<LogInProvider>(context, listen: false);
              prov.logOut();
            },
            tooltip: 'Log Out',
            icon: Icon(
              Icons.logout,
              color: Colors.black,
            ),
          ),
        ],
      ),
      body: Center(
        child: Text('This is the main screen'),
      ),
    );
  }
}