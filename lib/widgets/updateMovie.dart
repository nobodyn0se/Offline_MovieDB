import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
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
  String? tempPhoto;

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
              Container(
                height: 150,
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    Image.file(
                      File(tempPhoto ?? widget.movie.imagePath),
                      fit: BoxFit.cover,
                    ),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: CircleBorder(),
                          primary: Colors.yellow[700],
                        ),
                        onPressed: () async {
                          final ImagePicker _picker = ImagePicker();
                          final XFile? image = await _picker.pickImage(
                              source: ImageSource.gallery);
                          if (image != null)
                            setState(() {
                              tempPhoto = image.path;
                            });
                        },
                        child: Icon(Icons.edit_sharp),
                      ),
                    ),
                  ],
                ),
              ),
              TextFormField(
                initialValue: widget.movie.movieName,
                decoration: InputDecoration(hintText: 'Update movie name'),
                onChanged: (_) {
                  tempMovie = _;
                },
                validator: (tempMovie) => tempMovie == null || tempMovie.isEmpty
                    ? 'Movie name cannot be empty'
                    : null,
              ),
              TextFormField(
                initialValue: widget.movie.director,
                decoration:
                    InputDecoration(hintText: 'Update director\'s name'),
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
              final isValid = _formKey.currentState!.validate();

              if (isValid) {
                updateMovie();
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MainScreen(),
                  ),
                );
              }
            },
            child: Text('Update'),
          ),
        ],
      ),
    );
  }

  Future updateMovie() async {
    final mov = widget.movie.copy(
      isWatched: tempWatch,
      movieName: tempMovie,
      director: tempDir,
      imagePath: tempPhoto ?? widget.movie.imagePath,
    );

    await MoviesDatabase.instance.update(mov);
  }
}
