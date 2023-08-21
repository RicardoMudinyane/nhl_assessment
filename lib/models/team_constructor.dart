import 'roster_constructor.dart';


/// This is a constructor for all the data we are interested in about a Team

class NHLTeam {
  final int id;
  final String teamName;
  final String teamAbb;
  final String teamLogo;
  final String teamYear;
  final String teamWebsite;
  final String teamLocation;
  final String teamVenue;
  final String teamDivision;
  final String teamConference;
  final String teamFranchise;
  final String teamShortName;
  List<Roster>? rosters;

  NHLTeam({
    required this.id,
    required this.teamName,
    required this.teamAbb,
    required this.teamLogo,
    required this.teamYear,
    required this.teamWebsite,
    required this.teamLocation,
    required this.teamVenue,
    required this.teamDivision,
    required this.teamConference,
    required this.teamFranchise,
    required this.teamShortName,
    this.rosters,
  });
}