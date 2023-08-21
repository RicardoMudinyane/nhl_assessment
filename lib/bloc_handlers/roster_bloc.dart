import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:nhl_teams_app/models/roster_constructor.dart';
import 'dart:convert';

/// This class below contains a method use to fetch rosters for a specific team using that team Id

class RosterBloc extends Cubit<List<Roster>> {
  RosterBloc() : super([]);

  Future<void> fetchRoster(int teamId) async {
    final response = await http.get(Uri.parse('https://statsapi.web.nhl.com/api/v1/teams/$teamId/roster'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final rosterData = data['roster'] as List;
      final roster = rosterData.map((player) {
        return Roster(
            playerId: player['person']['id'],
            teamId: teamId,
            playerName: player['person']['fullName'],
            jerseyNumber: player['jerseyNumber'] ?? '',
            position: player['position']['name']
        );
      }).toList();
      emit(roster);
    }
    else {
      throw Exception('Failed to fetch roster for team $teamId');
    }
  }
}