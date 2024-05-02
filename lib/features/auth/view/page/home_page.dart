import 'package:flutter/material.dart';
import 'package:the_quran/features/auth/view/page/DataBaseHelper.dart';
import 'package:the_quran/features/auth/view/page/ProfilePage.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class Profile {
  int id;
  String firstName;
  String lastName;
  String bio;
  String favoriteReciters;

  Profile(this.id, this.firstName, this.lastName, this.bio, this.favoriteReciters);

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'id': id,
      'firstName': firstName,
      'lastName': lastName,
      'bio': bio,
      'favoriteReciters': favoriteReciters,
    };
    return map;
  }

  Profile.fromMap(Map<String, dynamic> map)
      : id = map['id'],
        firstName = map['firstName'],
        lastName = map['lastName'],
        bio = map['bio'],
        favoriteReciters = map['favoriteReciters'];
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();
  final TextEditingController _favoriteRecitersController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile Page'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          child: Column(
            children: [
              TextFormField(
                controller: _firstNameController,
                decoration: const InputDecoration(labelText: 'First Name'),
              ),
              TextFormField(
                controller: _lastNameController,
                decoration: const InputDecoration(labelText: 'Last Name'),
              ),
              TextFormField(
                controller: _bioController,
                decoration: const InputDecoration(labelText: 'Bio'),
              ),
              TextFormField(
                controller: _favoriteRecitersController,
                decoration: const InputDecoration(labelText: 'Favorite Reciters'),
              ),
              ElevatedButton(
                onPressed: () {
                  var user = Profile(
                    1,
                    _firstNameController.text,
                    _lastNameController.text,
                    _bioController.text,
                    _favoriteRecitersController.text,
                  );
                  DatabaseHelper.instance.insert(user.toMap());
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const ProfilePage()),
                  );
                },
                child: const Text('Create Profile'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _bioController.dispose();
    _favoriteRecitersController.dispose();
    super.dispose();
  }
}
