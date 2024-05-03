part of 'dashboard_bloc.dart';

@immutable
sealed class DashboardState {}

final class DashboardInitial extends DashboardState {}

final class DashboardProfileLoading extends DashboardState {}

final class DashboardProfileLoaded extends DashboardState {
  final UserDetails userDetails;
  final List<Reciter> reciters;

  DashboardProfileLoaded(this.userDetails, this.reciters);
}
