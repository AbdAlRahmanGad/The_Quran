import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_quran/features/dashboard/controller/bloc/dashboard_bloc.dart';

import '../../../auth/model/user_details.dart';

class ProfilePage extends StatefulWidget {
  final UserDetails userDetails;
  const ProfilePage({
    super.key,
    required this.userDetails,
  });

  @override
  ProfilePageState createState() => ProfilePageState(userDetails);
}

class ProfilePageState extends State<ProfilePage> {
  final UserDetails userDetails;

  ProfilePageState(this.userDetails);

  @override
  void initState() {
    super.initState();
    DashboardBloc dashboardBloc = context.read<DashboardBloc>();
    dashboardBloc.add(GetUserDetails());
  }

  @override
  Widget build(BuildContext context) {
    DashboardBloc dashboardBloc = context.read<DashboardBloc>();
    dashboardBloc.add(GetUserDetails());
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: ListView(
        children: <Widget>[
          ListTile(
            title: const Text('Full Name'),
            subtitle: Text(userDetails.userFullName),
          ),
          ListTile(
            title: const Text('Bio'),
            subtitle: Text(userDetails.userBio),
          ),
        ],
      ),
    );
  }
}
