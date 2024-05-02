import 'package:flutter/material.dart';
import 'package:the_quran/features/auth/view/page/databaseHelper.dart';

import 'package:the_quran/features/auth/view/page/home_page.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late Future<Profile> futureProfile;

  @override
  void initState() {
    super.initState();
    futureProfile = DatabaseHelper.instance.getProfile(1);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile Page'),
      ),
      body: FutureBuilder<Profile>(
        future: futureProfile,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            }

            return ListView(
              children: <Widget>[
                ListTile(
                  title: Text('First Name'),
                  subtitle: Text(snapshot.data!.firstName),
                ),
                ListTile(
                  title: Text('Last Name'),
                  subtitle: Text(snapshot.data!.lastName),
                ),
                ListTile(
                  title: Text('Bio'),
                  subtitle: Text(snapshot.data!.bio),
                ),
                ListTile(
                  title: Text('Favorite Reciters'),
                  subtitle: Text(snapshot.data!.favoriteReciters),
                ),
              ],
            );
          } else {
            return CircularProgressIndicator();
          }
        },
      ),
    );
  }
}
