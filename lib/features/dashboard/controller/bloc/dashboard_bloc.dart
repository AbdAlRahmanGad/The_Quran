import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:the_quran/features/dashboard/controller/database_helper.dart';
import 'package:the_quran/features/dashboard/controller/firebase_data.dart';

import '../../../auth/model/reciter.dart';
import '../../../auth/model/user_details.dart';

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
    on<GetUserDetails>((event, emit) async {
      emit(DashboardProfileLoading());
      final UserDetails userDetails =
          await DatabaseHelper.instance.getUserDetails(user!.uid);

      final List<Reciter> reciters =
          await DatabaseHelper.instance.getAllReciters();
      emit(DashboardProfileLoaded(userDetails, reciters));
    });
  }
}
