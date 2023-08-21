import '../models/team_constructor.dart';

/// These are the states that are there for our team bloc

abstract class TeamState {}

/// This state is returned when the method is retrieving data
class TeamLoading extends TeamState {}

/// This state is returned when data is retrieved
class TeamLoaded extends TeamState {
  final List<NHLTeam> teams;
  TeamLoaded(this.teams);
}

/// This state is returned when an error occurred
class TeamError extends TeamState {
  final String message;
  TeamError(this.message);
}