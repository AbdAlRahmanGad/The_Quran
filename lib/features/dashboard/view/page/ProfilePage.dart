import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_quran/features/dashboard/controller/bloc/dashboard_bloc.dart';
import 'package:the_quran/features/dashboard/controller/databaseHelper.dart';

import 'package:the_quran/features/auth/view/page/home_page.dart';

class ProfilePage extends StatefulWidget {
  final Profile p;
  const ProfilePage({Key? key, required this.p}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState(p);
}

class _ProfilePageState extends State<ProfilePage> {
  final Profile p;

  _ProfilePageState(this.p);

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    DashboardBloc dashboardBloc = context.read<DashboardBloc>();
    dashboardBloc.add(GetProfile());
    return Scaffold(
        appBar: AppBar(
          title: const Text('Profile Page'),
        ),
        body: ListView(
          children: <Widget>[
            ListTile(
              title: const Text('Full Name'),
              subtitle: Text(p.fullName),
            ),
            ListTile(
              title: const Text('Bio'),
              subtitle: Text(p.bio),
            ),
          ],
        ));
  }
}
