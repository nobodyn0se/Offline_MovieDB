import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:movies_database/db/moviesDatabase.dart';
import 'package:movies_database/dbmodel/dbModel.dart';
import 'package:movies_database/providers/logInProvider.dart';
import 'package:movies_database/widgets/addMovie.dart';
import 'package:movies_database/widgets/deleteMovie.dart';
import 'package:movies_database/widgets/updateMovie.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  bool isLoading = false;
  List<Movies> movies = [];

  Future retrieveNotes() async {
    setState(() => isLoading = true);
    await MoviesDatabase.instance.database; //closes old, returns new instance
    this.movies = await MoviesDatabase.instance.getMoviesList();
    setState(() => isLoading = false);
  }

  @override
  void initState() {
    retrieveNotes();
    super.initState();
  }

  @override
  void dispose() {
    MoviesDatabase.instance.close(); //close the db instance upon app exit
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
            //explicit statusBar color setup
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
              Navigator.popUntil(context,
                  (route) => route.isFirst); //removes all routes but one
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

  //opens Gallery image picker, returns image path from local storage
  Future pickImage() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      showForm(image.path);
    }
  }

  //shows a popup dialog with a form to add a movie
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

  //shows a popup dialog to confirm deletion
  void showDelete(int id) {
    showDialog(
        context: context,
        builder: (_) {
          return Center(
            child: DeleteMovie(movieID: id),
          );
        });
  }

  //shows a popup to update movie name, director name, watch status, thumbnail
  void updateForm(Movies movie) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (_) {
          return Center(
            child: UpdateMovie(movie: movie),
          );
        });
  }

  //main widget to display the listView of movie Cards
  ListView showList() {
    return ListView.builder(
      padding: EdgeInsets.only(bottom: 80),
      itemBuilder: (context, id) {
        final mov = movies[id];
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          child: Card(
            color: Colors.white,
            elevation: 10,
            shape: RoundedRectangleBorder(
              side: BorderSide(color: Colors.black87, width: 1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
              child: ListView(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                children: [
                  upperCard(
                      mov), //contains movie thumbnail, delete icon and watched tickBox
                  bottomCard(
                      mov), //contains movie name, director name and the update button
                  SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
          ),
        );
      },
      itemCount: movies.length,
    );
  }

  Stack upperCard(Movies mov) {
    return Stack(
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
            color: Colors.white.withOpacity(0.5),
            child: IconButton(
              iconSize: 20,
              color: Colors.black,
              icon: Icon(Icons.delete),
              onPressed: () {
                showDelete(mov.id!); //pass the id from the db
              },
            ),
          ),
        ),
        watchTickBox(mov),
      ],
    );
  }

  Positioned watchTickBox(Movies mov) {
    return Positioned(
      bottom: 13,
      left: 13,
      child: mov.isWatched
          ? Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  height: 25,
                  width: 25,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                ),
                Icon(
                  Icons.check_circle,
                  color: Colors.green[600],
                  size: 35,
                ),
              ],
            )
          : Text(''),
    );
  }

  Padding bottomCard(Movies mov) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0),
      child: Row(
        children: [
          Expanded(
            child: ListView(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              children: [
                Text(
                  '${mov.movieName}',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                Text(
                  'by ${mov.director}',
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              shape: CircleBorder(),
              primary: Colors.orange[700],
            ),
            onPressed: () {
              updateForm(mov);
            },
            child: Icon(Icons.edit_sharp),
          )
        ],
      ),
    );
  }
}
