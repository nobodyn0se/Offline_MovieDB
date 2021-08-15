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
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
            },
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
            }, //nav pop later
            child: Text('Add Movie'),
          ),
        ],
      ),
    );
  }
}
