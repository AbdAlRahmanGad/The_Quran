import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:the_quran/features/auth/view/page/home_page.dart';
import 'package:the_quran/features/dashboard/controller/databaseHelper.dart';
import 'package:the_quran/features/dashboard/controller/firebase_data.dart';

part 'dashboard_event.dart';
part 'dashboard_state.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  int selectedTapIndex = 0;

  final user = FirebaseRepo().fetch();
  final iconList = <IconData>[
    Icons.home,
    Icons.person,
    Icons.book,
    Icons.chrome_reader_mode_rounded,
  ];

  final PageController pageController = PageController();

  void onChangeTabIndex(int index) {
    selectedTapIndex = index;
    pageController.jumpToPage(selectedTapIndex);
  }

  DashboardBloc() : super(DashboardInitial()) {
    on<GetProfile>((event, emit) async {
      emit(DashboardProfileLoading());
      final Profile p = await DatabaseHelper.instance.getProfile(user!.uid);
      emit(DashboardProfileLoaded(p));
    });
  }
}
