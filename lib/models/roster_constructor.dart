
/// This is a constructor for all the data we are interested in about a Roster

class Roster {
  final int playerId;
  final int teamId;
  final String playerName;
  final String jerseyNumber;
  final String position;

  Roster({
    required this.playerId,
    required this.teamId,
    required this.playerName,
    required this.jerseyNumber,
    required this.position,
  });
}