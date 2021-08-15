import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movies_database/db/moviesDatabase.dart';
import 'package:movies_database/dbmodel/dbModel.dart';
import 'package:movies_database/screens/mainScreen.dart';

class UpdateMovie extends StatefulWidget {
  final Movies movie;
  const UpdateMovie({required this.movie});

  @override
  _UpdateMovieState createState() => _UpdateMovieState();
}

class _UpdateMovieState extends State<UpdateMovie> {
  final _formKey = GlobalKey<FormState>();
  String? tempMovie;
  String? tempDir;
  bool? tempWatch;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: AlertDialog(
        scrollable: false,
        title: const Text('Update movie details'),
        content: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Already watched'),
                  Transform.scale(
                    scale: 0.8,
                    child: CupertinoSwitch(
                      value: tempWatch == null
                          ? widget.movie.isWatched
                          : tempWatch!,
                      onChanged: (val) {
                        setState(() {
                          tempWatch = val;
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
                    File(widget.movie.imagePath),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              TextFormField(
                initialValue: widget.movie.movieName,
                decoration: InputDecoration(hintText: 'Movie Name'),
                onChanged: (_) {
                  tempMovie = _;
                },
                validator: (tempMovie) => tempMovie == null || tempMovie.isEmpty
                    ? 'Movie name cannot be empty'
                    : null,
              ),
              TextFormField(
                initialValue: widget.movie.director,
                decoration: InputDecoration(hintText: 'Directed by'),
                onChanged: (_) {
                  tempDir = _;
                },
                validator: (tempDir) => tempDir == null || tempDir.isEmpty
                    ? 'Director name cannot be empty'
                    : null,
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
            },
            child: Text('Update'),
          ),
        ],
      ),
    );
  }

}
