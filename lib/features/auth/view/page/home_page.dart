import 'package:flutter/material.dart';
import 'package:the_quran/features/dashboard/controller/database_helper.dart';
import 'package:the_quran/features/dashboard/controller/firebase_data.dart';
import 'package:the_quran/features/dashboard/view/page/dashboard_page.dart';

import '../../model/user_details.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Details'),
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
                  var userDetails = UserDetails(
                    userId: FirebaseRepo().fetch()!.uid,
                    userFullName: _fullNameController.text,
                    userBio: _bioController.text,
                    favouriteReciters: List.empty(),
                  );
                  DatabaseHelper.instance.insertUserDetails(userDetails);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const DashboardPage()),
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
