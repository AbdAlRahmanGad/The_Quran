import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_quran/core/utils/consts.dart';
import 'package:the_quran/features/auth/model/user_details.dart';
import 'package:the_quran/features/dashboard/controller/bloc/dashboard_bloc.dart';
import 'package:the_quran/features/dashboard/view/components/profile_widget.dart';
import 'package:the_quran/features/dashboard/view/page/edit_profile_page.dart';

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
        physics: const BouncingScrollPhysics(),
        children: [
          ProfileWidget(
            imagePath:
                Image.network(Consts.auth.currentUser!.photoURL.toString()),
            onClicked: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                    builder: (context) => const EditProfilePage()),
              );
            },
            network: true,
          ),
          const SizedBox(height: 24),
          Column(
            children: [
              Text(
                Consts.auth.currentUser!.displayName ?? " ",
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
              ),
              const SizedBox(height: 4),
              Text(
                Consts.auth.currentUser!.email ?? " ",
                style: const TextStyle(color: Colors.grey),
              )
            ],
          ),
          const SizedBox(height: 20),
          FilledButton(
            onPressed: () async {
              await Consts.auth.signOut();
            },
            child: const Text('Sign out'),
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}
