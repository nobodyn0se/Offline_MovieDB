import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:movies_database/providers/logInProvider.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';


class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<LogInProvider>(context);
    const String mainTitle = 'Movies Database';
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.network(
              provider.url,
              fit: BoxFit.fill,
            ),
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
        child: Text('This is the main screen'),
      ),
      floatingActionButton: FloatingActionButton(
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
}
