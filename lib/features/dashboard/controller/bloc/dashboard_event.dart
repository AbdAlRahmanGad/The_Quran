part of 'dashboard_bloc.dart';

@immutable
sealed class DashboardEvent {}

class GetProfile extends DashboardEvent {
  List<Object> get props => [];
}
