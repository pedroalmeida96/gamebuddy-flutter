class GameType {
  final String name;

  GameType({required this.name});

  factory GameType.fromJson(Map<String, dynamic> json) {
    return GameType(
      name: json['name'],
    );
  }
}
