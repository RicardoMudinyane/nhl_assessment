import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:nhl_teams_app/bloc_handlers/team_state.dart';
import 'dart:convert';

import '../models/get_logos.dart';
import '../models/team_constructor.dart';


class TeamBloc extends Cubit<TeamState> {
  TeamBloc() : super(TeamLoading());

  List<NHLTeam> teams = [];
  String currentSearch = '';

  /// This method returns try to fetch teams from the NHL API
  Future<void> fetchTeams() async {
    try{
      final response = await http.get(Uri.parse('https://statsapi.web.nhl.com/api/v1/teams'));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final teamsData = data['teams'] as List;

        final List<Future<NHLTeam>> teamCollection = teamsData.map((team) async {
          var image = await LogosAPI().getLogos(team['officialSiteUrl']);
          return NHLTeam(
            id: team['id'],
            teamName: team['name'],
            teamAbb: team['abbreviation'],
            teamLogo: image,
            teamWebsite: team['officialSiteUrl'],
            teamLocation: team['locationName'],
            teamYear: team['firstYearOfPlay'],
            teamDivision: team['division']['name'],
            teamVenue: team['venue']['name'],
            teamConference: team['conference']['name'],
            teamFranchise: team['franchise']['teamName'],
            teamShortName: team['shortName'],
          );
        }).toList();

        teams = await Future.wait(teamCollection);
        applyFilter('All Teams');
      }
      else {
        throw Exception('Failed to fetch teams');
      }
    }
    catch (error){
      /// This state is returned if an error occurred
      emit(TeamError('Error Message: $error'));
    }
  }

  /// This method apply filters to the team using the team conference
  /// We can also include filters by division here(or more)... time wasn't on my side
  void applyFilter(String filter) {
    late List<NHLTeam> filteredTeams;
    switch (filter) {
      case 'All Teams':
        filteredTeams = teams;
        break;
      case 'Eastern':
        filteredTeams = teams.where((team) => team.teamConference == 'Eastern').toList();
        break;
      case 'Western':
        filteredTeams =  teams.where((team) => team.teamConference == 'Western').toList();
        break;
      default:
        filteredTeams = teams;
        break;
    }
    emit(TeamLoaded(filteredTeams));
  }

  /// This method is called the user types on the search textfield
  void applySearch(String name) {
    late List<NHLTeam> filteredTeams;
    currentSearch = name;
    if (currentSearch.isEmpty) {
      filteredTeams = teams;
    }
    else {
      final lowerCaseQuery = currentSearch.toLowerCase();
      filteredTeams = teams.where((team) {
        return team.teamName.toLowerCase().contains(lowerCaseQuery);
      }).toList();
    }
    emit(TeamLoaded(filteredTeams));
  }
}