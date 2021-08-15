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
              ),
              TextFormField(
                initialValue: widget.movie.director,
                decoration: InputDecoration(hintText: 'Directed by'),
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
