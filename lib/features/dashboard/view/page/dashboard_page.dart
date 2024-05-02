import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_quran/features/auth/view/page/home_page.dart';
import 'package:the_quran/features/dashboard/controller/bloc/dashboard_bloc.dart';
import 'package:the_quran/features/dashboard/view/page/ProfilePage.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DashboardBloc(),
      child: BlocBuilder<DashboardBloc, DashboardState>(
        builder: (context, state) {
          Profile p = Profile("", "", "");
          DashboardBloc controller = context.read<DashboardBloc>();
          controller.add(GetProfile());
          if (state is DashboardProfileLoaded) p = state.profile;
          return Scaffold(
            body: SafeArea(
              child: PageView(
                controller: controller.pageController,
                onPageChanged: controller.onChangeTabIndex,
                children: [
                  const Text('test'),
                  const Text("Home"),
                  ProfilePage(
                    p: p,
                  ),
                ],
              ),
            ),
            bottomNavigationBar: NavigationBar(
              onDestinationSelected: (int index) {
                controller.onChangeTabIndex(index);
              },
              indicatorColor: Colors.green,
              selectedIndex: controller.selectedTapIndex,
              destinations: const <Widget>[
                NavigationDestination(
                  selectedIcon: Icon(Icons.people),
                  icon: Icon(Icons.people_alt_outlined),
                  label: 'القراء',
                ),
                NavigationDestination(
                  icon: Icon(Icons.home),
                  selectedIcon: Icon(Icons.home),
                  label: 'الرئسية',
                ),
                NavigationDestination(
                  selectedIcon: Icon(Icons.my_library_books_sharp),
                  icon: Icon(Icons.my_library_books_sharp),
                  label: 'ملف شخصي',
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
