import 'package:flutter/material.dart';
import 'package:movies_database/db/moviesDatabase.dart';
import 'package:movies_database/screens/mainScreen.dart';

class DeleteMovie extends StatelessWidget {
  final int movieID;
  DeleteMovie({required this.movieID});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      scrollable: false,
      title: Text('Do you want to delete this movie?'),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text('Go Back'),
        ),
        TextButton(
          onPressed: () {
            deleteMovie(context);
          },
          child: Text('Delete'),
        ),
      ],
    );
  }

  Future deleteMovie(context) async {
    await MoviesDatabase.instance.delete(movieID);
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => MainScreen(),
      ),
    );
  }
}
