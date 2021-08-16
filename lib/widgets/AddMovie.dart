import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movies_database/db/moviesDatabase.dart';
import 'package:movies_database/dbmodel/dbModel.dart';
import 'package:movies_database/screens/mainScreen.dart';

class AddMovie extends StatefulWidget {
  const AddMovie({required this.path});
  final String path;

  @override
  _AddMovieState createState() => _AddMovieState();
}

class _AddMovieState extends State<AddMovie> {
  bool switchState = false;
  String? movieName;
  String? directorName;
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: AlertDialog(
        scrollable: false,
        //title: Text('Dummy Screen'),
        content: Form(
          key: formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Did you watch it?'),
                  Transform.scale(
                    scale: 0.8,
                    child: CupertinoSwitch(
                      value: switchState,
                      onChanged: (val) {
                        setState(() {
                          switchState = !switchState;
                        });
                      },
                    ),
                  ),
                ],
              ),
              IntrinsicWidth(
                child: Container(
                  height: 150,
                  child: Image.file(
                    File(widget.path),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              TextFormField(
                initialValue: movieName, //TBA
                decoration: InputDecoration(hintText: 'Movie Name'),
                validator: (movieName) =>
                    movieName == null || movieName.isEmpty ? 'Not empty' : null,
                onChanged: (_) {
                  movieName = _;
                },
              ),
              TextFormField(
                  decoration: InputDecoration(hintText: 'Director Name'),
                  validator: (directorName) =>
                      directorName == null || directorName.isEmpty
                          ? 'Director Name cannot be empty'
                          : null,
                  onChanged: (_) {
                    directorName = _;
                  } //the change function here
                  ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              final isValid = formKey.currentState!.validate();
              if (isValid) {
                addMovie();
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MainScreen(),
                  ),
                );
              }
            }, //nav pop later
            child: Text('Add Movie'),
          ),
        ],
      ),
    );
  }

  Future addMovie() async {
    final movie = Movies(
      director: directorName!,
      movieName: movieName!,
      imagePath: widget.path,
      isWatched: switchState,
      time: DateTime.now(),
    );

    await MoviesDatabase.instance.create(movie);
  }
}
