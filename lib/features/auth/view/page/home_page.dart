import 'package:flutter/material.dart';
import 'package:the_quran/features/dashboard/controller/databaseHelper.dart';
import 'package:the_quran/features/dashboard/controller/firebase_data.dart';
import 'package:the_quran/features/dashboard/view/page/ProfilePage.dart';
import 'package:the_quran/features/dashboard/view/page/dashboard_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class Profile {
  String uid;
  String fullName;
  String bio;

  Profile(
    this.uid,
    this.fullName,
    this.bio,
  );

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'uid': uid,
      'fullName': fullName,
      'bio': bio,
    };
    return map;
  }

  Profile.fromMap(Map<String, dynamic> map)
      : uid = map['uid'],
        fullName = map['fullName'],
        bio = map['bio'];
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();

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
                controller: _fullNameController,
                decoration: const InputDecoration(labelText: 'Full Name'),
              ),
              TextFormField(
                controller: _bioController,
                decoration: const InputDecoration(labelText: 'Bio'),
              ),
              ElevatedButton(
                onPressed: () {
                  var user = Profile(
                    FirebaseRepo().fetch()!.uid,
                    _fullNameController.text,
                    _bioController.text,
                  );
                  DatabaseHelper.instance.insert(user.toMap());
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const DashbordPage()),
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
    _fullNameController.dispose();
    _bioController.dispose();
    super.dispose();
  }
}
