import 'appuser.dart';

class Game {
  final String gameId;
  final String gameType;
  final String location;
  final String gameDateTime;
  final List<AppUser> participants;
  final int? version;

  Game({
    required this.gameId,
    required this.gameType,
    required this.location,
    required this.gameDateTime,
    required this.participants,
    this.version,
  });

  factory Game.fromJson(Map<String, dynamic> json) {
    return Game(
      gameId: json['gameId'],
      gameType: json['gameType'],
      location: json['location'],
      gameDateTime: json['gameDateTime'],
      participants: (json['participants'] as List<dynamic>)
          .map((participantJson) => AppUser.fromJson(participantJson))
          .toList(),
      version: json['version'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'gameId': gameId,
      'gameType': gameType,
      'location': location,
      'gameDateTime': gameDateTime,
      'participants':
          participants.map((participant) => participant.toJson()).toList(),
      'version': version, // Serialize version to JSON
    };
  }

  @override
  String toString() {
    return 'Game: {gameId: $gameId, gameType: $gameType, location: $location, gameDateTime: $gameDateTime, participants: $participants, version: $version}';
  }
}
