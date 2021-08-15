import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:movies_database/db/moviesDatabase.dart';
import 'package:movies_database/dbmodel/dbModel.dart';
import 'package:movies_database/providers/logInProvider.dart';
import 'package:movies_database/widgets/AddMovie.dart';
import 'package:movies_database/widgets/deleteMovie.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  bool isLoading = false;
  late final prov;
  List<Movies> movies = [];

  Future retrieveNotes() async {
    setState(() => isLoading = true);
    await MoviesDatabase.instance.database;
    this.movies = await MoviesDatabase.instance.getMoviesList();
    setState(() => isLoading = false);
    print('List called');
  }

  @override
  void initState() {
    retrieveNotes();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    prov = Provider.of<LogInProvider>(context, listen: false);
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    MoviesDatabase.instance.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const String mainTitle = 'Movies Database';

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.asset('assets/google_logo.png'),
          ),
        ),
        elevation: 0,
        backwardsCompatibility: false,
        systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: Colors.white,
            statusBarIconBrightness: Brightness.dark),
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
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Logged out'),
                ),
              );
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
        child: isLoading
            ? CircularProgressIndicator()
            : movies.isEmpty
                ? Text('Watchlist empty! Add some movies')
                : showList(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          pickImage();
        },
        foregroundColor: Colors.black,
        backgroundColor: Colors.grey[400],
        tooltip: 'Add Movies',
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        child: Icon(
          Icons.add_task,
        ),
      ),
    );
  }

  void pickImage() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      showForm(image.path);
    }
  }

  void showForm(String path) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (_) {
          return Center(
            child: AddMovie(path: path),
          );
        });
  }

  void showDelete(int id) {
    showDialog(
        context: context,
        builder: (_) {
          return Center(
            child: DeleteMovie(movieID: id),
          );
        });
  }

  ListView showList() {
    return ListView.builder(
      padding: EdgeInsets.only(bottom: 80),
      itemBuilder: (context, id) {
        final mov = movies[id];
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          child: Card(
            color: mov.isWatched == true ? Colors.grey : Colors.white,
            elevation: 5,
            shape: RoundedRectangleBorder(
              side: BorderSide(color: Colors.black87, width: 1),
              borderRadius: BorderRadius.circular(10),
                ),
                DefaultTextStyle(
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      backgroundColor: Colors.black54),
                  child: ListView(
              physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    children: [
                Stack(
                  alignment: AlignmentDirectional.bottomStart,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: 180,
                        width: double.maxFinite,
                        child: Image.file(
                          File(mov.imagePath),
                          fit: BoxFit.fitWidth,
                        ),
                  ),
                ),
                Positioned(
                      top: 8,
                      right: 8,
                  child: Container(
                        color: mov.isWatched ? Colors.grey : Colors.white,
                    child: IconButton(
                      iconSize: 20,
                      color: Colors.black,
                      icon: Icon(Icons.delete),
                      onPressed: () {
                        showDelete(mov.id!);
                      },
                    ),
                      ),
                    ),
                    Positioned(
                      top: 8,
                      left: 8,
                      child: mov.isWatched
                          ? Text(
                              'Watched already',
                              style: TextStyle(backgroundColor: Colors.green),
                            )
                          : Text(''),
                    ),
                  ],
                ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
      itemCount: movies.length,
    );
  }
}
