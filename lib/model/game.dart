class Game {
  final String gameId;
  final String gameType;
  final String location;
  final String gameDateTime;

  Game({
    required this.gameId,
    required this.gameType,
    required this.location,
    required this.gameDateTime,
  });

  factory Game.fromJson(Map<String, dynamic> json) {
    return Game(
      gameId: json['gameId'],
      gameType: json['gameType'],
      location: json['location'],
      gameDateTime: json['gameDateTime'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'gameId': gameId,
      'gameType': gameType,
      'location': location,
      'gameDateTime': gameDateTime,
    };
  }
}