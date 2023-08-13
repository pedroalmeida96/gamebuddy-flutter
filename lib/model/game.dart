import 'appuser.dart';

class Game {
  final int? gameId;
  final String gameType;
  final String location;
  final String gameDateTime;
  final List<AppUser> participants;

  Game(
      {this.gameId,
      required this.gameType,
      required this.location,
      required this.gameDateTime,
      required this.participants});

  factory Game.fromJson(Map<String, dynamic> json) {
    return Game(
      gameId: json['gameId'],
      gameType: json['gameType'],
      location: json['location'],
      gameDateTime: json['gameDateTime'],
      participants: (json['participants'] as List<dynamic>)
          .map((participantJson) => AppUser.fromJson(participantJson))
          .toList(),
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
    };
  }

  @override
  String toString() {
    return 'Game: {gameId: $gameId, gameType: $gameType, location: $location, gameDateTime: $gameDateTime, participants: $participants}';
  }
}
