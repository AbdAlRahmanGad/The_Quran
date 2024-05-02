part of 'dashboard_bloc.dart';

@immutable
sealed class DashboardState {}

final class DashboardInitial extends DashboardState {}

final class DashboardProfuleLoading extends DashboardState {}

final class DashboardProfuleLoaded extends DashboardState {
  final Profile profile;

  DashboardProfuleLoaded(this.profile);
}
